# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arphicfonts/arphicfonts-0.1-r1.ebuild,v 1.17 2004/11/04 05:26:55 vapier Exp $

DESCRIPTION="Chinese TrueType Arphic Fonts"
HOMEPAGE="http://www.arphic.com.tw/"
SRC_URI="ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bsmi00lp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gbsn00lp.ttf.gz"

LICENSE="Arphic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

DEPEND="virtual/x11
	x11-misc/ttmkfdir"

S=${WORKDIR}

src_install() {
	insopts -m0644
	insinto /usr/share/fonts/ttf/zh_TW
	doins b*.ttf
	if test -r /usr/share/fonts/ttf/zh_TW/fonts.scale; then
		tail -n +2 /usr/share/fonts/ttf/zh_TW/fonts.scale > tmp
		tail -n +2 ${FILESDIR}/TW-fonts.scale >> tmp
		echo $(sort -u tmp | wc -l) > newfont.scale
		sort -u tmp >> newfont.scale
		newins newfont.scale fonts.scale
	else
		newins ${FILESDIR}/TW-fonts.scale fonts.scale
	fi
	insinto /usr/share/fonts/ttf/zh_CN
	doins g*.ttf
	if test -r /usr/share/fonts/ttf/zh_CN/fonts.scale; then
		tail -n +2 /usr/share/fonts/ttf/zh_CN/fonts.scale > tmp
		tail -n +2 ${FILESDIR}/CN-fonts.scale >> tmp
		echo $(sort -u tmp | wc -l) > newfont.scale
		sort -u tmp >> newfont.scale
		newins newfont.scale fonts.scale
	else
		newins ${FILESDIR}/CN-fonts.scale fonts.scale
	fi

#	These don't get downloaded because there is no simple way to
#	fetch them.. ie if I included the README in SRC_URI above, it would
#	get saved as ${DISTDIR}/README which doesn't seem like
#	a really good idea.
#	dodoc LICENSE README
}

pkg_postinst() {
	cd /usr/share/fonts/ttf/zh_TW
	mkfontdir -e /usr/share/fonts/encodings/large \
		-e /usr/share/fonts/encodings
	cd /usr/share/fonts/ttf/zh_CN
	mkfontdir -e /usr/share/fonts/encodings/large \
		-e /usr/share/fonts/encodings

	if ( ! `grep -qie "FontPath.*/usr/share/fonts/ttf/zh_TW" /etc/X11/XF86Config` ); then
		einfo "You must add /usr/share/fonts/ttf/zh_TW to the font paths in XF86Config"
	fi
	if ( ! `grep -qie "FontPath.*/usr/share/fonts/ttf/zh_CN" /etc/X11/XF86Config` ); then
		einfo "You must add /usr/share/fonts/ttf/zh_CN to the font paths in XF86Config"
	fi

	einfo "Restart font server for changes to take effect."
}

pkg_postrm() {
#	FIXME: fonts.scale files should be cleaned up if necessary
	einfo
	einfo "You may need to remove the following lines from 'Section \"Files\"' in"
	einfo "XF86Config, to unmerge this package completely:"
	einfo "\t FontPath \"/usr/share/fonts/ttf/zh_TW\""
	einfo "\t FontPath \"/usr/share/fonts/ttf/zh_CN\""
	einfo
}
