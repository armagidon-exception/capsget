const std = @import("std");
var stdout_buffer: [5]u8 = undefined;
var writer = std.fs.File.stdout().writer(&stdout_buffer);
var stdout = &writer.interface;

const x11 = @cImport({
    @cInclude("X11/Xlib.h");
    @cInclude("X11/XKBlib.h");
});

pub fn main() !void {
    const display = x11.XOpenDisplay(@as(?*u8, null));
    defer _ = x11.XCloseDisplay(display);
    const atom = x11.XInternAtom(display, "Caps Lock", 0);
    var ndx_rtrn: c_int = undefined;
    var state_rtrn: c_int = undefined;
    var map_rtrn: x11.struct__XkbIndicatorMapRec = undefined;
    var real_rtrn: c_int = undefined;

    _ = x11.XkbGetNamedIndicator(display, atom, &ndx_rtrn, &state_rtrn, &map_rtrn, &real_rtrn);

    try stdout.print("{d}\n", .{state_rtrn});
    try stdout.flush();
}
