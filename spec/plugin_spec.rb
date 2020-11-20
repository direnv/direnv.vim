require 'spec_helper'
require 'timeout'

describe "My Vim plugin" do
  it "should not fail" do
    expect(vim.command("echo $HELLO")).not_to eq("world")
  end

  it "should load allowed .envrc files" do
    fixture_dir = File.expand_path("../fixtures/simple", __FILE__)
    system("direnv allow #{fixture_dir}")

    vim.command("cd spec/fixtures/simple")
    vim.command("call direnv#export()")

    expect(vim.command("echo $HELLO")).to eq("world")

    vim.command("cd ..")
    vim.command("DirenvExport")
    expect(vim.command("echo $HELLO")).not_to eq("world")
  end
end
