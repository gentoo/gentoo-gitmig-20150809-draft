set execfail on
source 2>/dev/null ${PORTDIR}/media-video/ffmpeg/${ffversion}.ebuild
declare -f | sed -e 's/src_/ffmpeg_src_/'
