require "rails_helper"

describe "投稿のテスト" do
  let!(:list) {create(:list,title:"hoge",body:"body")}
  describe "トップ画面(top_path)のテスト" do
    before do
      visit top_path
    end
    context "表示の確認" do
    it "トップ画面に(top_path)に「ここはTopページです」が表示されている" do
      expect(page).to have_context "ここはTopページです"
    end
    it "top_pathが"/top"であるか" do
      expect(current_path).to eq("/top")
    end
  end
end

describe "投稿画面(todolists_new_path)のテスト" do
  before do
    visit todolists_new_path
  end
  context "表示の確認" do
    it "todolists_new_pathが/todolists/newである" do
      expect(current_path).to eq("/todolists/new")
    end
    it "投稿ボタンが表示されているのか" do
      expect(page)to have_button "投稿"
    end
  end
  
  context "投稿の処理テスト" do
     it "投稿のリダイレクト先は正しいですか？"
     fill_in "list[title]",with: Faker::Lorem.characters(number:5)
     fill_in "list[body]",with: Faker::Lorem.characters(number:20)
     click_button "投稿"
     expect(page).to have_current_path todolist_path(List.last)
   end
  end
  
   describe "投稿一覧のテスト" do
     before do
       visit todolist_path
     end
     context  "表示確認" do
       it "投稿されたものが表示されているのか" do
         expect(page).to have_content list.title
         expect(page).to have_link list.title
       end
     end
 end
 
 describe "詳細画面のテスト" do
 before do
   visit todolist_path(list)
 end
 context "表示の確認" do
   it "削除リンクが存在しているのか" do
     expect(page).to have_link "削除"
   end
   it "編集のリンクが存在しているのか" do
     expect(page).to have_link "編集" do
     end
   end
   context "リンク遷移先の確認"
   it "編集の遷移先は編集画面" do
     edit_link = find_all("a")[3]
     edit_link.click
     expect(current_path).to eq("/todolists" + list.id.to_s + "/edit")
   end
   context "list削除のテスト" do
     it "listの削除" do
       expect {list.destroy}.to change{List.count}.by(-1)
     end
   end
 end
 
 describe "編集画面のテスト" do
 before do
   visit edit_todolist_path(list)
 end
 context "表示の確認" do
   it "編集前のタイトルと本文がフォームに表示されている" do
   expect(page).to have_field "list[title]",with: list.title
   expect(page).to have_field "list[body]",with: list.body
 end
   it "保存ボタンが表示されている" do
     expect(page).to have_button "保存"
   end
 end
 
 context "更新処理に関するテスト" do
    it "更新後のリダイレクト先は正しいか" do
    fii_in "list[title]",with: Faker::Lorem.characters(number:5)
    fill_in "list[body]",with: Faker::Lorem.characters(number:20)
    click_button "保存"
    expect(page).to have_current_path todolist_path(list)
   end
   end
 end
 end