# ~/nixos-config/helix.nix
# import from home.nix: imports = [ ./helix.nix ];
{ pkgs, ... }:
{
  programs.helix = {
    enable = true;
    defaultEditor = true;

    # language servers helix can find on PATH
    extraPackages = with pkgs; [
      gopls
      clang-tools # clangd
      nil         # nix lsp
      nixfmt
    ];

    settings = {
      theme = "crimson";

      editor = {
        line-number = "relative";
        cursorline = true;
        true-color = true;
        bufferline = "multiple";
        color-modes = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        indent-guides.render = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
      };

      keys.insert."C-c" = "normal_mode";
      keys.select."C-c" = "normal_mode";
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "nixfmt";
      }
    ];

    themes.crimson = {
      # no bg on ui.background = terminal (and foot's alpha) shows through
      "ui.background" = { };
      "ui.text" = "fg";
      "ui.text.focus" = { fg = "fg"; modifiers = [ "bold" ]; };
      "ui.cursor" = { fg = "bg0"; bg = "rose"; };
      "ui.cursor.primary" = { fg = "bg0"; bg = "crimson"; };
      "ui.cursor.match" = { fg = "crimson_bright"; modifiers = [ "bold" "underlined" ]; };
      "ui.selection" = { bg = "wine"; };
      "ui.selection.primary" = { bg = "wine"; };
      "ui.cursorline.primary" = { bg = "bg1"; };
      "ui.linenr" = "bg3";
      "ui.linenr.selected" = "crimson";
      "ui.gutter" = { };
      "ui.statusline" = { fg = "fg"; bg = "bg1"; };
      "ui.statusline.inactive" = { fg = "muted"; bg = "bg1"; };
      "ui.statusline.normal" = { fg = "bg0"; bg = "crimson"; modifiers = [ "bold" ]; };
      "ui.statusline.insert" = { fg = "bg0"; bg = "green"; modifiers = [ "bold" ]; };
      "ui.statusline.select" = { fg = "bg0"; bg = "yellow"; modifiers = [ "bold" ]; };
      "ui.bufferline" = { fg = "muted"; bg = "bg1"; };
      "ui.bufferline.active" = { fg = "fg"; bg = "wine"; };
      "ui.popup" = { bg = "bg1"; };
      "ui.window" = "bg3";
      "ui.help" = { fg = "fg"; bg = "bg1"; };
      "ui.menu" = { fg = "fg"; bg = "bg1"; };
      "ui.menu.selected" = { fg = "bg0"; bg = "crimson"; };
      "ui.virtual.indent-guide" = "bg2";
      "ui.virtual.whitespace" = "bg2";
      "ui.virtual.ruler" = { bg = "bg1"; };
      "ui.virtual.inlay-hint" = { fg = "bg3"; modifiers = [ "italic" ]; };

      "comment" = { fg = "muted"; modifiers = [ "italic" ]; };
      "keyword" = "crimson";
      "keyword.control" = "crimson_bright";
      "function" = "rose";
      "function.builtin" = "magenta";
      "type" = "cyan";
      "type.builtin" = "cyan";
      "constructor" = "cyan";
      "string" = "green";
      "constant" = "yellow";
      "constant.numeric" = "yellow";
      "constant.character.escape" = "magenta";
      "variable" = "fg";
      "variable.builtin" = "magenta";
      "variable.parameter" = "blue";
      "attribute" = "yellow";
      "namespace" = "blue";
      "operator" = "rose";
      "punctuation" = "muted";
      "label" = "crimson";
      "tag" = "crimson";

      "markup.heading" = { fg = "crimson"; modifiers = [ "bold" ]; };
      "markup.bold" = { modifiers = [ "bold" ]; };
      "markup.italic" = { modifiers = [ "italic" ]; };
      "markup.link.url" = { fg = "blue"; modifiers = [ "underlined" ]; };
      "markup.raw" = "green";

      "diff.plus" = "green";
      "diff.minus" = "crimson";
      "diff.delta" = "yellow";

      "error" = "crimson_bright";
      "warning" = "yellow";
      "info" = "blue";
      "hint" = "muted";
      "diagnostic.error" = { underline = { color = "crimson_bright"; style = "curl"; }; };
      "diagnostic.warning" = { underline = { color = "yellow"; style = "curl"; }; };
      "diagnostic.info" = { underline = { color = "blue"; style = "curl"; }; };
      "diagnostic.hint" = { underline = { color = "muted"; style = "curl"; }; };

      palette = {
        bg0 = "#0f0a0c";
        bg1 = "#1a1215";
        bg2 = "#2a1c21";
        bg3 = "#4a3a40";
        fg = "#d6d2d4";
        muted = "#8a7a80";
        crimson = "#c3143c";
        crimson_bright = "#e0385e";
        wine = "#5c1022";
        rose = "#c95a7c";
        magenta = "#a8385a";
        green = "#8a9a6e";
        yellow = "#c9a26b";
        blue = "#7a7f9a";
        cyan = "#8a9ea0";
      };
    };
  };
}
