#!/bin/bash

# ==============================================================================
# KIỂM TRA PHỤ THUỘC (DEPENDENCIES)
# ==============================================================================
if ! command -v gum &> /dev/null; then
    echo "❌ Lỗi / Error: Script này yêu cầu 'gum' để hiển thị giao diện tương tác / This script requires 'gum' for the interactive UI."
    echo "Vui lòng cài đặt gum trước / Please install gum first (Tham khảo: https://github.com/charmbracelet/gum#installation)"
    echo "  - macOS: brew install gum"
    echo "  - Arch Linux: sudo pacman -S gum"
    echo "  - Ubuntu/Debian: sudo mkdir -p /etc/apt/keyrings && curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg && echo \"deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *\" | sudo tee /etc/apt/sources.list.d/charm.list && sudo apt update && sudo apt install gum"
    exit 1
fi

if ! command -v unzip &> /dev/null; then
    echo "❌ Lỗi / Error: Script này yêu cầu 'unzip' để cài đặt UOSC / This script requires 'unzip' for UOSC installation."
    echo "Vui lòng cài đặt unzip trước / Please install unzip first."
    exit 1
fi

# ==============================================================================
# CHỌN NGÔN NGỮ (LANGUAGE SELECTION)
# ==============================================================================
LANG_CHOICE=$(gum choose "Tiếng Việt" "English" --header "Chọn ngôn ngữ / Choose your language:")

if [ "$LANG_CHOICE" == "English" ]; then
    # --- ENGLISH DICTIONARY ---
    HEADER_TITLE="MPV OSC & FEATURES INSTALLER (GUM VERSION)"
    OSC_HEADER="🎬 CHOOSE INTERFACE (OSC):"
    OSC_SKIP="X. Skip OSC installation"
    OSC_PROMPT="Use Up/Down arrows to move, Enter to select:"
    MSG_OSC_DOWNLOADING="Downloading interface"
    MSG_FONT_DOWNLOADING="Downloading font"
    MSG_CONF_DOWNLOADING="Downloading config"
    MSG_OSC_SUCCESS="✔️ Interfaces installed successfully!"
    MSG_OSC_SKIPPED="⚠️ Skipped interface installation."

    SUB_HEADER="📝 CHOOSE SUBTITLE FEATURES:"
    SUB_PROMPT="Use SPACE to toggle, ENTER to confirm:"
    MSG_SUB_DOWNLOADING="Downloading"
    MSG_SUB_SUCCESS="✔️ Subtitle features installed!"
    MSG_SUB_SKIPPED="⚠️ Skipped subtitle features."

    THUMB_HEADER="🖼️ INSTALL THUMBFAST (PREVIEW THUMBNAILS):"
    THUMB_PROMPT="Install Thumbfast?"
    MSG_THUMB_DOWNLOADING="Downloading Thumbfast..."
    MSG_THUMB_SUCCESS="✔️ Thumbfast installed!"
    MSG_THUMB_SKIPPED="⚠️ Skipped Thumbfast."

    CONFLICT_HEADER="🔍 CONFLICT CHECK:"
    CONFLICT_WARN="⚠️ Potential conflicts detected:"
    CONFLICT_PROMPT="Delete them automatically to prevent errors?"
    MSG_CLEAN_SUCCESS="✔️ Environment cleaned successfully!"
    MSG_CLEAN_SKIPPED="⚠️ Cleanup skipped."
    MSG_ENV_CLEAN="✔️ Environment is clean, no conflicts detected."

    MSG_ALL_DONE="🎉 ALL DONE! Open mpv to enjoy."

    OSC_DESCRIPTIONS=(
        "Feature-rich UI with integrated menus"
        "Polished, most popular"
        "Minimalist, lightweight"
        "Upgraded ModernX"
        "Feature-rich fork"
        "Small progress bar"
        "Dark orange theme"
        "Bomi icons & PIP button"
        "Dark-themed box"
        "Ultra-minimalist bar"
        "Compact web-player UI"
        "Light-themed box"
    )
    SUB_DESCRIPTIONS=(
        "[Universal] Auto-select sub tracks"
        "[Universal] Auto-sync subtitles"
        "[Universal] List & search subtitle lines"
        "[Learn EN] Pause for listening practice"
        "[Learn EN] Copy for dictionary"
        "[Universal] Remember selected subs"
        "[EN/VI] Auto-download subs"
        "[Learn EN] AI translate & explain"
    )

    ADDON_HEADER="🧩 CHOOSE EXTRA ADD-ONS:"
    ADDON_PROMPT="Use SPACE to toggle, ENTER to confirm:"
    MSG_ADDON_DOWNLOADING="Downloading"
    MSG_ADDON_SUCCESS="✔️ Add-ons installed!"
    MSG_ADDON_SKIPPED="⚠️ Skipped extra add-ons."

    ADDON_DESCRIPTIONS=(
        "Copy/paste URLs directly into mpv"
        "Create WebM/MP4 clips easily"
        "Change YouTube/stream quality via menu"
        "Auto-crop black borders"
        "Auto-load next files in folder"
        "Advanced playlist management menu"
        "Recent files history & menu"
        "Reload stream/video if it gets stuck"
    )
else
    # --- VIETNAMESE DICTIONARY ---
    HEADER_TITLE="CÀI ĐẶT MPV OSC & TÍNH NĂNG (GUM VERSION)"
    OSC_HEADER="🎬 CHỌN GIAO DIỆN (OSC):"
    OSC_SKIP="X. Không cài OSC (Bỏ qua)"
    OSC_PROMPT="Sử dụng Phím mũi tên Lên/Xuống để di chuyển, Enter để chọn:"
    MSG_OSC_DOWNLOADING="Đang tải giao diện"
    MSG_FONT_DOWNLOADING="Đang tải font"
    MSG_CONF_DOWNLOADING="Đang tải file cấu hình"
    MSG_OSC_SUCCESS="✔️ Cài đặt giao diện thành công!"
    MSG_OSC_SKIPPED="⚠️ Đã bỏ qua cài đặt giao diện."

    SUB_HEADER="📝 CHỌN TÍNH NĂNG PHỤ ĐỀ:"
    SUB_PROMPT="Dùng SPACE để đánh dấu/bỏ đánh dấu, ENTER để xác nhận:"
    MSG_SUB_DOWNLOADING="Đang tải"
    MSG_SUB_SUCCESS="✔️ Đã tải các tính năng phụ đề!"
    MSG_SUB_SKIPPED="⚠️ Đã bỏ qua tính năng phụ đề."

    THUMB_HEADER="🖼️ CÀI ĐẶT THUMBFAST (ẢNH THU NHỎ):"
    THUMB_PROMPT="Cài thêm Thumbfast (Hiển thị ảnh thu nhỏ khi tua)?"
    MSG_THUMB_DOWNLOADING="Đang tải Thumbfast..."
    MSG_THUMB_SUCCESS="✔️ Đã cài đặt Thumbfast!"
    MSG_THUMB_SKIPPED="⚠️ Đã bỏ qua Thumbfast."

    CONFLICT_HEADER="🔍 KIỂM TRA XUNG ĐỘT MÔI TRƯỜNG:"
    CONFLICT_WARN="⚠️ Phát hiện các file có nguy cơ gây xung đột:"
    CONFLICT_PROMPT="Bạn có muốn tự động xoá chúng để tránh lỗi không?"
    MSG_CLEAN_SUCCESS="✔️ Đã dọn dẹp môi trường sạch sẽ!"
    MSG_CLEAN_SKIPPED="⚠️ Đã bỏ qua dọn dẹp. Vui lòng tự kiểm tra nếu giao diện bị lỗi."
    MSG_ENV_CLEAN="✔️ Môi trường sạch sẽ, không phát hiện rủi ro xung đột."

    MSG_ALL_DONE="🎉 HOÀN TẤT TẤT CẢ! Hãy mở mpv để trải nghiệm."

    OSC_DESCRIPTIONS=(
        "Giao diện đa tính năng, có menu tích hợp cực đẹp"
        "Bóng bẩy, phổ biến nhất"
        "Tối giản, nhẹ nhàng"
        "Bản nâng cấp của ModernX"
        "Fork ModernX nhiều tính năng"
        "Dạng thanh tiến trình nhỏ"
        "Phong cách màu cam tối"
        "Icon Bomi & Nút Hình-trong-Hình"
        "Giao diện dạng hộp tối màu"
        "Thanh tiến trình siêu nhỏ"
        "Giao diện nhỏ gọn giống web"
        "Giao diện dạng hộp sáng màu"
    )
    SUB_DESCRIPTIONS=(
        "[Đa năng] Tự động chọn track phụ đề"
        "[Đa năng] Đồng bộ phụ đề"
        "[Đa năng] Liệt kê & tìm kiếm dòng phụ đề"
        "[Học Ngoại Ngữ] Dừng cuối câu để luyện nghe"
        "[Học Ngoại Ngữ] Copy phụ đề tra từ điển"
        "[Đa năng] Ghi nhớ phụ đề đã chọn"
        "[Việt/Anh] Tải phụ đề tự động"
        "[Học Ngoại Ngữ] Dịch & giải thích bằng AI"
    )

    ADDON_HEADER="🧩 CHỌN TÍNH NĂNG BỔ TRỢ (ADD-ONS):"
    ADDON_PROMPT="Dùng SPACE để đánh dấu/bỏ đánh dấu, ENTER để xác nhận:"
    MSG_ADDON_DOWNLOADING="Đang tải"
    MSG_ADDON_SUCCESS="✔️ Đã tải các tính năng bổ trợ!"
    MSG_ADDON_SKIPPED="⚠️ Đã bỏ qua tính năng bổ trợ."

    ADDON_DESCRIPTIONS=(
        "Copy/Paste URL/File trực tiếp vào mpv"
        "Cắt nhanh đoạn video thành WebM/MP4/GIF"
        "Đổi độ phân giải YouTube/Stream qua menu"
        "Tự động cắt bỏ viền đen của video"
        "Tự động load các file cùng thư mục vào list"
        "Menu quản lý danh sách phát nâng cao"
        "Lịch sử xem video và mở lại nhanh"
        "Tải lại video/stream khi bị đứng hình"
    )
fi

# ==============================================================================
# CẤU HÌNH THƯ MỤC
# ==============================================================================
MPV_DIR="$HOME/.config/mpv"
SCRIPTS_DIR="$MPV_DIR/scripts"
FONTS_DIR="$MPV_DIR/fonts"
SCRIPT_OPTS_DIR="$MPV_DIR/script-opts"
MPV_CONF="$MPV_DIR/mpv.conf"
THUMBFAST_LUA="$SCRIPTS_DIR/thumbfast.lua"

mkdir -p "$SCRIPTS_DIR" "$FONTS_DIR" "$SCRIPT_OPTS_DIR"

# ==============================================================================
# DATA: OSC (GIAO DIỆN)
# ==============================================================================
OSC_NAMES=(
    "uosc (tomasklaen)"
    "ModernX (cyl0)"
    "osc-modern (maoiscat)"
    "ModernZ (Samillion)"
    "ModernX Fork (zydezu)"
    "progressbar (torque)"
    "osc-orange (maoiscat)"
    "tethys (Zren)"
    "dark-box (maoiscat)"
    "mfpbar (shinchiro)"
    "ModernX Compact (1-minute)"
    "light-box (maoiscat)"
)
OSC_LUA_URLS=(
    "SPECIAL_UOSC"
    "https://raw.githubusercontent.com/cyl0/ModernX/main/modernx.lua"
    "https://raw.githubusercontent.com/maoiscat/mpv-osc-modern/master/osc-modern.lua"
    "https://raw.githubusercontent.com/Samillion/ModernZ/main/modernz.lua"
    "https://raw.githubusercontent.com/zydezu/ModernX/main/modernx.lua"
    "https://raw.githubusercontent.com/torque/mpv-progressbar/master/progressbar.lua"
    "https://raw.githubusercontent.com/maoiscat/mpv-osc-orange/master/osc-orange.lua"
    "https://raw.githubusercontent.com/Zren/mpv-osc-tethys/master/osc_tethys.lua"
    "https://raw.githubusercontent.com/maoiscat/mpv-dark-box/master/dark-box.lua"
    "https://raw.githubusercontent.com/shinchiro/mpv-mfpbar/master/mfpbar.lua"
    "https://raw.githubusercontent.com/1-minute-to-midnight/mpv-modern-x-compact/main/modernx.lua"
    "https://raw.githubusercontent.com/maoiscat/mpv-light-box/master/light-box.lua"
)
OSC_LUA_FILES=(
    "uosc.lua"
    "modernx.lua"
    "osc-modern.lua"
    "modernz.lua"
    "modernx_zydezu.lua"
    "progressbar.lua"
    "osc-orange.lua"
    "osc_tethys.lua"
    "dark-box.lua"
    "mfpbar.lua"
    "modernx-compact.lua"
    "light-box.lua"
)
OSC_FONT_NAMES=(
    ""
    "Material-Design-Iconic-Font.ttf"
    "mpv-osd-symbols.ttf"
    "modernz-icons.ttf"
    "Material-Design-Iconic-Font.ttf"
    ""
    "mpv-osd-symbols.ttf"
    ""
    ""
    ""
    "Material-Design-Iconic-Font.ttf"
    ""
)
OSC_FONT_URLS=(
    ""
    "https://raw.githubusercontent.com/cyl0/ModernX/main/Material-Design-Iconic-Font.ttf"
    "https://raw.githubusercontent.com/maoiscat/mpv-osc-modern/master/mpv-osd-symbols.ttf"
    "https://raw.githubusercontent.com/Samillion/ModernZ/main/modernz-icons.ttf"
    "https://raw.githubusercontent.com/zydezu/ModernX/main/Material-Design-Iconic-Font.ttf"
    ""
    "https://raw.githubusercontent.com/maoiscat/mpv-osc-orange/master/mpv-osd-symbols.ttf"
    ""
    ""
    ""
    "https://raw.githubusercontent.com/cyl0/ModernX/main/Material-Design-Iconic-Font.ttf"
    ""
)
OSC_CONF_URLS=(
    ""
    "https://raw.githubusercontent.com/cyl0/ModernX/main/modernx.conf"
    ""
    "https://raw.githubusercontent.com/Samillion/ModernZ/main/modernz.conf"
    ""
    ""
    ""
    ""
    ""
    ""
    ""
    ""
)
OSC_CONF_FILES=(
    "uosc.conf"
    "modernx.conf"
    ""
    "modernz.conf"
    ""
    ""
    ""
    ""
    ""
    ""
    ""
    ""
)

# ==============================================================================
# DATA: SUBTITLE (PHỤ ĐỀ)
# ==============================================================================
SUB_NAMES=(
    "sub-select (CogentRedTester)"
    "autosubsync (Ajatt-Tools)"
    "subtitle-lines (christoph-heinrich)"
    "sub-pause (Ben-Kerman)"
    "copy-subtitle (linguisticmind)"
    "restore-subtitles (zenwarr)"
    "autosub (davidde)"
    "subai (zenwarr)"
)
SUB_URLS=(
    "https://raw.githubusercontent.com/CogentRedTester/mpv-sub-select/master/sub-select.lua"
    "https://raw.githubusercontent.com/Ajatt-Tools/autosubsync-mpv/master/autosubsync.lua"
    "https://raw.githubusercontent.com/christoph-heinrich/mpv-subtitle-lines/master/subtitle-lines.lua"
    "https://raw.githubusercontent.com/Ben-Kerman/mpv-sub-scripts/master/sub-pause.lua"
    "https://raw.githubusercontent.com/linguisticmind/mpv-scripts/master/copy-subtitle/copy-subtitle.lua"
    "https://raw.githubusercontent.com/zenwarr/mpv-config/master/scripts/restore-subtitles.lua"
    "https://raw.githubusercontent.com/davidde/mpv-autosub/master/autosub.lua"
    "https://raw.githubusercontent.com/zenwarr/mpv-config/master/scripts/subai.lua"
)
SUB_FILES=(
    "sub-select.lua"
    "autosubsync.lua"
    "subtitle-lines.lua"
    "sub-pause.lua"
    "copy-subtitle.lua"
    "restore-subtitles.lua"
    "autosub.lua"
    "subai.lua"
)

# ==============================================================================
# DATA: ADD-ONS (BỔ TRỢ)
# ==============================================================================
ADDON_NAMES=(
    "SmartCopyPaste (Eisa01)"
    "Mpv-WebM (ekisu)"
    "Quality Menu (christoph-heinrich)"
    "Autocrop (FichteFoll)"
    "Autoload (mpv-player)"
    "PlaylistManager (jonniek)"
    "Memo / History (po5)"
    "Reload (4e6)"
)
ADDON_URLS=(
    "https://raw.githubusercontent.com/Eisa01/mpv-scripts/master/scripts/SmartCopyPaste_II.lua"
    "https://raw.githubusercontent.com/ekisu/mpv-webm/master/webm.lua"
    "https://raw.githubusercontent.com/christoph-heinrich/mpv-quality-menu/master/quality-menu.lua"
    "https://raw.githubusercontent.com/FichteFoll/mpv-scripts/master/autocrop.lua"
    "https://raw.githubusercontent.com/mpv-player/mpv/master/TOOLS/lua/autoload.lua"
    "https://raw.githubusercontent.com/jonniek/mpv-playlistmanager/master/playlistmanager.lua"
    "https://raw.githubusercontent.com/po5/memo/master/memo.lua"
    "https://raw.githubusercontent.com/4e6/mpv-reload/master/reload.lua"
)
ADDON_FILES=(
    "SmartCopyPaste_II.lua"
    "webm.lua"
    "quality-menu.lua"
    "autocrop.lua"
    "autoload.lua"
    "playlistmanager.lua"
    "memo.lua"
    "reload.lua"
)

# ==============================================================================
# HEADER
# ==============================================================================
clear
gum style \
    --foreground 212 --border-foreground 212 --border double \
    --align center --width 60 --margin "1 2" --padding "1 2" \
    "$HEADER_TITLE"

# TẮT OSC MẶC ĐỊNH / DISABLE DEFAULT OSC
if [ -f "$MPV_CONF" ]; then
    if ! grep -q "^osc=no" "$MPV_CONF"; then
        echo "osc=no" >> "$MPV_CONF"
    fi
else
    echo "osc=no" > "$MPV_CONF"
fi

# ==============================================================================
# MENU 1: CHỌN OSC (SINGLE CHOICE)
# ==============================================================================
osc_options=()
for i in "${!OSC_NAMES[@]}"; do
    osc_options+=("$i. ${OSC_NAMES[$i]} - ${OSC_DESCRIPTIONS[$i]}")
done
osc_options+=("$OSC_SKIP")

echo "$OSC_HEADER"
selected_osc=$(gum choose "${osc_options[@]}" --header "$OSC_PROMPT")
lua_file_to_keep=""

if [[ "$selected_osc" != "X."* && -n "$selected_osc" ]]; then
    idx=$(echo "$selected_osc" | cut -d'.' -f1)

    # Dọn dẹp script và font cũ để CHỐNG XUNG ĐỘT / CLEANUP TO PREVENT CONFLICTS
    rm -rf "$SCRIPTS_DIR/uosc"
    rm -f "$SCRIPTS_DIR/uosc.lua" "$SCRIPTS_DIR/osc.lua" "$SCRIPTS_DIR/modernx.lua" "$SCRIPTS_DIR/osc-modern.lua" "$SCRIPTS_DIR/modernz.lua" "$SCRIPTS_DIR/modernx_zydezu.lua" "$SCRIPTS_DIR/progressbar.lua" "$SCRIPTS_DIR/osc-orange.lua" "$SCRIPTS_DIR/osc_tethys.lua" "$SCRIPTS_DIR/dark-box.lua" "$SCRIPTS_DIR/mfpbar.lua" "$SCRIPTS_DIR/modernx-compact.lua" "$SCRIPTS_DIR/light-box.lua"
    rm -f "$FONTS_DIR/Material-Design-Iconic-Font.ttf" "$FONTS_DIR/mpv-osd-symbols.ttf" "$FONTS_DIR/FluentSystemIcons-Regular.ttf" "$FONTS_DIR/modernz-icons.ttf" "$FONTS_DIR/uosc_icons.otf" "$FONTS_DIR/uosc_textures.ttf"
    rm -f "$SCRIPT_OPTS_DIR/modernx.conf" "$SCRIPT_OPTS_DIR/modernz.conf" "$SCRIPT_OPTS_DIR/uosc.conf"

    lua_url="${OSC_LUA_URLS[$idx]}"
    lua_file="${OSC_LUA_FILES[$idx]}"
    font_name="${OSC_FONT_NAMES[$idx]}"
    font_url="${OSC_FONT_URLS[$idx]}"
    conf_url="${OSC_CONF_URLS[$idx]}"
    conf_file="${OSC_CONF_FILES[$idx]}"

    lua_file_to_keep="$lua_file"

    if [ "$lua_url" == "SPECIAL_UOSC" ]; then
        gum spin --spinner dot --title "$MSG_OSC_DOWNLOADING ${OSC_NAMES[$idx]}..." -- bash -c "curl -fL -s -o /tmp/uosc.zip https://github.com/tomasklaen/uosc/releases/latest/download/uosc.zip && unzip -q -o /tmp/uosc.zip -d \"$MPV_DIR\" && rm /tmp/uosc.zip"
    else
        gum spin --spinner dot --title "$MSG_OSC_DOWNLOADING ${OSC_NAMES[$idx]}..." -- curl -fL -s -o "$SCRIPTS_DIR/$lua_file" "$lua_url"

        if [ -n "$font_name" ]; then
            gum spin --spinner dot --title "$MSG_FONT_DOWNLOADING $font_name..." -- curl -fL -s -o "$FONTS_DIR/$font_name" "$font_url"
        fi

        if [ -n "$conf_url" ]; then
            gum spin --spinner dot --title "$MSG_CONF_DOWNLOADING $conf_file..." -- curl -fL -s -o "$SCRIPT_OPTS_DIR/$conf_file" "$conf_url"
        fi
    fi

    gum style --foreground 46 "$MSG_OSC_SUCCESS"
else
    gum style --foreground 226 "$MSG_OSC_SKIPPED"
fi

# ==============================================================================
# MENU 2: CHỌN SUBTITLE (MULTI-SELECT)
# ==============================================================================
echo ""
echo "$SUB_HEADER"
sub_options=()
for i in "${!SUB_NAMES[@]}"; do
    sub_options+=("$i. ${SUB_NAMES[$i]} - ${SUB_DESCRIPTIONS[$i]}")
done

selected_subs=$(gum choose --no-limit "${sub_options[@]}" --header "$SUB_PROMPT")

if [ -n "$selected_subs" ]; then
    # Duyệt qua từng dòng kết quả
    while IFS= read -r line; do
        idx=$(echo "$line" | cut -d'.' -f1)
        gum spin --spinner dot --title "$MSG_SUB_DOWNLOADING ${SUB_NAMES[$idx]}..." -- curl -fL -s -o "$SCRIPTS_DIR/${SUB_FILES[$idx]}" "${SUB_URLS[$idx]}"
    done <<< "$selected_subs"
    gum style --foreground 46 "$MSG_SUB_SUCCESS"
else
    gum style --foreground 226 "$MSG_SUB_SKIPPED"
fi

# ==============================================================================
# MENU 3: CHỌN ADD-ONS (MULTI-SELECT)
# ==============================================================================
echo ""
echo "$ADDON_HEADER"
addon_options=()
for i in "${!ADDON_NAMES[@]}"; do
    addon_options+=("$i. ${ADDON_NAMES[$i]} - ${ADDON_DESCRIPTIONS[$i]}")
done

selected_addons=$(gum choose --no-limit "${addon_options[@]}" --header "$ADDON_PROMPT")

if [ -n "$selected_addons" ]; then
    while IFS= read -r line; do
        idx=$(echo "$line" | cut -d'.' -f1)
        gum spin --spinner dot --title "$MSG_ADDON_DOWNLOADING ${ADDON_NAMES[$idx]}..." -- curl -fL -s -o "$SCRIPTS_DIR/${ADDON_FILES[$idx]}" "${ADDON_URLS[$idx]}"
    done <<< "$selected_addons"
    gum style --foreground 46 "$MSG_ADDON_SUCCESS"
else
    gum style --foreground 226 "$MSG_ADDON_SKIPPED"
fi

# ==============================================================================
# MENU 4: CÀI ĐẶT THUMBFAST (HÌNH THU NHỎ)
# ==============================================================================
echo ""
echo "$THUMB_HEADER"
if gum confirm "$THUMB_PROMPT"; then
    gum spin --spinner dot --title "$MSG_THUMB_DOWNLOADING" -- curl -fL -s -o "$THUMBFAST_LUA" "https://raw.githubusercontent.com/po5/thumbfast/master/thumbfast.lua"
    gum style --foreground 46 "$MSG_THUMB_SUCCESS"
else
    [ -f "$THUMBFAST_LUA" ] && rm "$THUMBFAST_LUA"
    gum style --foreground 226 "$MSG_THUMB_SKIPPED"
fi

# ==============================================================================
# KIỂM TRA XUNG ĐỘT LẦN CUỐI / FINAL CONFLICT CHECK
# ==============================================================================
echo ""
echo "$CONFLICT_HEADER"
CONFLICTS=()
POTENTIAL_CONFLICTS=("uosc.lua" "osc.lua" "modernx.lua" "modernz.lua" "modernx_zydezu.lua" "osc-modern.lua" "uosc.lua" "progressbar.lua" "osc-orange.lua" "mfpbar.lua" "mpv_thumbnail_script.lua" "mpv_thumbnail_script_client_osc.lua" "osc_tethys.lua" "dark-box.lua" "light-box.lua" "modernx-compact.lua")

# Quét tìm các file .lua cũ, BỎ QUA file giao diện vừa mới cài đặt
for conflict_file in "${POTENTIAL_CONFLICTS[@]}"; do
    if [[ -f "$SCRIPTS_DIR/$conflict_file" && "$conflict_file" != "$lua_file_to_keep" ]]; then
        CONFLICTS+=("$SCRIPTS_DIR/$conflict_file")
    fi
done

if [[ -d "$SCRIPTS_DIR/uosc" && "$lua_file_to_keep" != "uosc.lua" ]]; then
    CONFLICTS+=("$SCRIPTS_DIR/uosc")
fi

if [ ${#CONFLICTS[@]} -gt 0 ]; then
    echo "$CONFLICT_WARN"
    for item in "${CONFLICTS[@]}"; do
        echo "  - $item"
    done

    echo ""
    if gum confirm "$CONFLICT_PROMPT"; then
        for item in "${CONFLICTS[@]}"; do
            rm -rf "$item"
        done
        gum style --foreground 46 "$MSG_CLEAN_SUCCESS"
    else
        gum style --foreground 208 "$MSG_CLEAN_SKIPPED"
    fi
else
    gum style --foreground 46 "$MSG_ENV_CLEAN"
fi

echo ""
gum style --foreground 212 --bold "$MSG_ALL_DONE"
