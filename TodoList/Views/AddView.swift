//
//  AddView.swift
//  TodoList
//
//  Created by Felipe Reis on 16/02/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismissView
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    @State var alerTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                TextField("Type something here...", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 55)
                    .background(Color(#colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)))
                    .cornerRadius(10)
                
                Button( action: saveButtonPressed, label: {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                })
            }.padding(14)
            
        }
        .navigationTitle("Add an Item 🖋️")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    func saveButtonPressed() {
        if (!textIsAppropiate()) {
            alerTitle = "You new todo item must be at least 3 characters long 😨"
            showAlert.toggle()
            return
        }
        
        listViewModel.addItem(title: textFieldText)
        dismissView()
    }
    
    func textIsAppropiate() -> Bool {
        return textFieldText.count >= 3
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alerTitle))
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            AddView()
        }
        .environmentObject(ListViewModel())
    }
}
