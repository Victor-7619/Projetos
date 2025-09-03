function adicionarTarefa() //função para adicionar tarefa
{
        let mensagem = "Tarefa adicionada com sucesso!" // declaração de variável

        let inputTarefa = document.getElementById("inputTarefa") // declaração de variável que chama algo com o id inputTarefa no HTML
        let Tarefa = inputTarefa.value // declaração de variável que pega o valor digitado no input
        document.getElementById("mensagem").textContent = mensagem // mostra a mensagem de sucesso no parágrafo com id mensagem

        let Lista = document.getElementById("Lista") // declaração de variável que chama algo com o id Lista no HTML(a ul)
        let novaTarefa = document.createElement("li") // cria um elemento de lista(li)
        
        novaTarefa.textContent = Tarefa // jogando o valor do que foi digitado para o li

        Lista.appendChild(novaTarefa) // adiciona o li na ul

        inputTarefa.value = "" // limpa o input após adicionar a tarefa
}