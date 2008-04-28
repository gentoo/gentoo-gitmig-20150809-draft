# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/vdr-epgsearch/vdr-epgsearch-0.9.24_rc2.ebuild,v 1.1 2008/04/28 16:45:09 zzam Exp $

inherit vdr-plugin

DESCRIPTION="Video Disk Recorder epgsearch plugin"
HOMEPAGE="http://winni.vdr-developer.org/epgsearch"

case ${P#*_} in
	rc*|beta*)
		MY_P="${P/_/.}"
		SRC_URI="http://winni.vdr-developer.org/epgsearch/downloads/beta/${MY_P}.tgz"
		S="${WORKDIR}/${MY_P#vdr-}"
		;;
	*)
		SRC_URI="http://winni.vdr-developer.org/epgsearch/downloads/${P}.tgz"
		;;
esac

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pcre"

DEPEND=">=media-video/vdr-1.3.45
	pcre? ( dev-libs/libpcre )"

src_unpack() {
	vdr-plugin_src_unpack

	cd "${S}"
	fix_vdr_libsi_include conflictcheck.c

	use pcre && sed -i Makefile -e 's/^#HAVE_PCREPOSIX/HAVE_PCREPOSIX/'
}

src_install() {
	vdr-plugin_src_install
	diropts "-m755 -o vdr -g vdr"
	keepdir /etc/vdr/plugins/epgsearch

	cd "${S}"
	emake install-doc MANDIR="${D}/usr/share/man"
	dodoc MANUAL
}

pkg_postinst() {
	vdr-plugin_pkg_postinst
	if has_version "<media-plugins/vdr-epgsearch-0.9.18"; then
		elog "Moving config-files to new location /etc/vdr/plugins/epgsearch"
		cd "${ROOT}"/etc/vdr/plugins
		local f
		local moved=""
		for f in epgsearch*.* .epgsearch*; do
			[[ -e ${f} ]] || continue
			mv "${f}" "${ROOT}/etc/vdr/plugins/epgsearch"
			moved="${moved} ${f}"
		done
		elog "These files were moved:${moved}"
	fi
}
