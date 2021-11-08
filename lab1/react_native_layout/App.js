import React from "react";
import { View, Image, StyleSheet, Text, Button, TextInput } from "react-native";

export default function App() {
  return (
    <View style={styles.body}>
      <View style={styles.appbar}>
        <Text style={styles.title}>Example 1</Text>
      </View>
      <View style={styles.container}>
        <Image
          style={styles.logo}
          source={{ uri: "https://reactnative.dev/img/tiny_logo.png" }}
        />
      </View>
      <View style={styles.row}>
        <Button title="Button"></Button>
        <Button title="Button"></Button>
      </View>
      <View style={styles.row}>
        <Button title="Button"></Button>
        <Button title="Button"></Button>
      </View>
      <View style={styles.row}>
        <Text style={styles.prefix}>Email</Text>
        <TextInput style={styles.emailForm} keyboardType="email-address" />
      </View>
    </View>
  );
}

const styles = StyleSheet.create({
  body: {
    flex: 1,
  },
  appbar: {
    paddingTop: 40,
    padding: 10,
    alignItems: "center",
    flexDirection: "row",
    backgroundColor: "#387",
  },
  title: {
    fontSize: 28,
    color: "#fff",
  },
  container: {
    justifyContent: "center",
    alignItems: "center",
    height: 200,
  },
  logo: {
    width: 166,
    height: 158,
  },
  row: {
    padding: 10,
    flexDirection: "row",
    justifyContent: "space-evenly",
    alignItems: "center",
  },
  emailForm: {
    flex: 0.8,
    padding: 10,
    backgroundColor: "#fff",
    borderBottomColor: "#000",
    borderBottomWidth: 1,
  },
  prefix: {
    padding: 10,
    paddingEnd: 25,
  },
});
