# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-fonts/arphicfonts/arphicfonts-0.1-r1.ebuild,v 1.8 2004/01/09 22:40:37 weeve Exp $

S=${WORKDIR}
DESCRIPTION="Arphic Fonts"
HOMEPAGE="http://www.arphic.com.tw/"
SRC_URI="ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bsmi00lp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gbsn00lp.ttf.gz"

SLOT="0"
LICENSE="Arphic"
KEYWORDS="ia64 x86 ppc ~alpha sparc hppa amd64"

DEPEND="virtual/x11
	x11-misc/ttmkfdir"

src_install() {
	insopts -m0644
	insinto /usr/share/fonts/ttf/zh_TW
	doins b*.ttf
	if test -r /usr/share/fonts/ttf/zh_TW/fonts.scale; then
		tail +2 /usr/share/fonts/ttf/zh_TW/fonts.scale > tmp
		tail +2 ${FILESDIR}/TW-fonts.scale >> tmp
		echo $(sort -u tmp | wc -l) > newfont.scale
		sort -u tmp >> newfont.scale
		newins newfont.scale fonts.scale
	else
		newins ${FILESDIR}/TW-fonts.scale fonts.scale
	fi
	insinto /usr/share/fonts/ttf/zh_CN
	doins g*.ttf
	if test -r /usr/share/fonts/ttf/zh_CN/fonts.scale; then
		tail +2 /usr/share/fonts/ttf/zh_CN/fonts.scale > tmp
		tail +2 ${FILESDIR}/CN-fonts.scale >> tmp
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
	echo ">>> Making big5 font dirs..."
	cd /usr/share/fonts/ttf/zh_TW
	echo ">>> Creating fonts.dir info"
	mkfontdir -e /usr/share/fonts/encodings/large \
	-e /usr/share/fonts/encodings
	echo ">>> Making gb2312 font dirs..."
	cd /usr/share/fonts/ttf/zh_CN
	echo ">>> Creating fonts.dir info"
	mkfontdir -e /usr/share/fonts/encodings/large \
	-e /usr/share/fonts/encodings
	echo ">>> Make sure X knows about these font directories!"
	if (  `grep -e "^.*FontPath.*\"/usr/share/fonts/ttf/zh_TW\"" /etc/X11/XF86Config -q` ); then
		echo "Font path for big5 fonts is listed in /etc/X11/XF86Config."
	else
		echo ">>> You must add /usr/share/fonts/ttf/zh_TW to your font path"
		echo ">>> to be able to use your new Big5 fonts."
	fi
	if (  `grep -e "^.*[fF]ont[Pp]ath.*\"/usr/share/fonts/ttf/zh_CN\"" /etc/X11/XF86Config -q` ); then
		echo "Font path for gb2312 fonts is listed in /etc/X11/XF86Config."
	else
		echo ">>> You must add /usr/share/fonts/ttf/zh_CN to your font path"
		echo ">>> to be able to use your new gb2312 fonts."
	fi

	echo ">>> Restart font server for changes to take effect."
}
