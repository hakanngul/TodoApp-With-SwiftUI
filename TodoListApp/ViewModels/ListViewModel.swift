//
//  ListViewModel.swift
//  TodoListApp
//
//  Created by Hakan Gül on 11.03.2023.
//

import Foundation
/*
 CRUD FUNCTIONS
 
 CREATE
 READ
 UPDATE
 DELETE
 
 */
class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            //Her set edilmede yani crud da saveItems çalıştırılacak.
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
        let data = UserDefaults.standard.data(forKey: itemsKey),
        let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet)  {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(title: String) {
        let newItem = ItemModel(title: title, isCompleted: false)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: {$0.id == item.id}) {
            items[index] = item.updateCompletion()
        }
    }
    
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items) {
            //LocalStorage gibi kayıt yapıyor.
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
