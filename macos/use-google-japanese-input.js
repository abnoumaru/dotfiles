// Installing Google Japanese Input registers it but leaves it disabled, so the kana key keeps selecting Kotoeri.
ObjC.import("Carbon");

function inputSources() {
  const list = ObjC.castRefToObject($.TISCreateInputSourceList($({}), true));
  return Array.from({ length: list.count }, (_, i) => {
    const source = list.objectAtIndex(i);
    const id = ObjC.castRefToObject($.TISGetInputSourceProperty(source, $.kTISPropertyInputSourceID)).js;
    return { id, source };
  });
}

function run() {
  const sources = inputSources();
  sources.filter(({ id }) => ["com.google.inputmethod.Japanese", "com.google.inputmethod.Japanese.base"].includes(id)).forEach(({ source }) => $.TISEnableInputSource(source));
  sources.filter(({ id }) => id.startsWith("com.apple.inputmethod.Kotoeri.")).forEach(({ source }) => $.TISDisableInputSource(source));
}
