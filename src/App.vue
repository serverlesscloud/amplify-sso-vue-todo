<template>
  <amplify-authenticator>
    <div id="app">
      <h1>Todo App</h1>
      <input type="text" v-model="name" placeholder="Todo name">
      <input type="text" v-model="description" placeholder="Todo description">
      <button v-on:click="createTodo">Create Todo</button>
    </div>

    <div id="app" class="container">

      <form id="translator">
        <p>
          <textarea type="text" 
          v-model="fromText" placeholder="Enter text to be translated..." 
          rows="3"
          max-rows="6"/>
<!-- 
          <label>From Language:</label>
          <select v-model="fromLanguage" >
            <option v-for="option in options" :key="option.text" :value = "option.text" >
              {{ option.value }}
            </option>
          </select>

          <label>To Language:</label>
          <select v-model="toLanguage">
            <option v-for="option in options" :key="option.text" :value = "option.text" >
              {{ option.value }}
            </option>
          </select> -->

          <button v-on:click="translateText">Translate</button>
        </p>

        <textarea type="text" 
          v-model="toText" placeholder="Translated text will appear here..." 
          rows="3"
          max-rows="6"/>
      </form>
    </div>
    <amplify-sign-out></amplify-sign-out>

  </amplify-authenticator>
</template>

<script>
import { API } from 'aws-amplify';
import { createTodo } from './graphql/mutations';
import { listTodos } from './graphql/queries';
import { onCreateTodo } from './graphql/subscriptions';
import { Predictions } from "aws-amplify";


export default {
  name: 'app',
  data() {
    return {
      name: '',
      description: '',

      fromLanguage: "",
      toLanguage: "",
      fromText: "",
      toText: "",
      options: [
        { value: "", text: "Please select an option" },
        { value: "ar", text: "Arabic" },
        { value: "cs", text: "Czech" },
        { value: "zh", text: "Chinese" },
        { value: "en", text: "English" },
        { value: "fr", text: "French" },
        { value: "de", text: "German" },
        { value: "it", text: "Italian" },
        { value: "ja", text: "Japanese" },
        { value: "pt", text: "Portuguese" },
        { value: "ru", text: "Russian" },
        { value: "es", text: "Spanish" },
        { value: "tr", text: "Turkish" }
      ]
    }
  },
  create(){
    this.getTodos();
    this.subscribe();
  },
  methods: {
    async createTodo() {
      const { name, description } = this;
      if (!name || !description) return;
      const todo = { name, description };
      await API.graphql({
        query: createTodo,
        variables: {input: todo},
      });
      this.name = '';
      this.description = '';
    },
    async getTodos() {
      const todos = await API.graphql({
        query: listTodos
      });
      this.todos = todos.data.listTodos.items;
    },
    subscribe() {
      API.graphql({ query: onCreateTodo })
        .subscribe({
          next: (eventData) => {
            let todo = eventData.value.data.onCreateTodo;
            if (this.todos.some(item => item.name === todo.name)) return; // remove duplications
            this.todos = [...this.todos, todo];
          }
        });
    },
    async translateText() {
      let translation = await Predictions.convert({
        translateText: {
          source: {
            text: this.fromText,
            // language: this.fromLanguage
          },
          // targetLanguage: this.toLanguage,
        }
      })
      .catch(err => console.log({ err }));
       
      this.toText = "translated text:" + translation.text;
      console.log (this.fromLanguage);
      console.log (this.toLanguage);
      console.log( this.toText )
    }
  }
};
</script>