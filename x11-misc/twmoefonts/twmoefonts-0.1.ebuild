# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/twmoefonts/twmoefonts-0.1.ebuild,v 1.1 2002/11/06 14:59:23 stubear Exp $

IUSE=""
DESCRIPTION="Standard tranditional Chinese fonts made by Minister of Education (MOE), Republic of China."
SRC_URI="ftp://ftp.ncu.edu.tw/FreeBSD/distfiles/zh-moettf/moe_kai.ttf
	ftp://ftp.ncu.edu.tw/FreeBSD/distfiles/zh-moettf/moe_sung.ttf"
HOMEPAGE=""	# Unable to find homepage
LICENSE="public-domain"
SLOT="0"
KEYWORDS="~x86 ~sparc ~sparc64"
DEPEND="x11-misc/ttmkfdir"
RDEPEND="virtual/glibc"

src_unpack() {
	mkdir ${WORKDIR}/${P}
	cp ${DISTDIR}/moe_kai.ttf ${WORKDIR}/${P}/moe_kai.ttf
	cp ${DISTDIR}/moe_sung.ttf ${WORKDIR}/${P}/moe_sung.ttf
}

src_install() {
	insopts -m0644
	insinto /usr/share/fonts/ttf/zh_TW
	doins *.ttf
	if test -r /usr/share/fonts/ttf/zh_TW/fonts.scale; then
	    ORIGC=$(head -1 /usr/share/fonts/ttf/zh_TW/fonts.scale)
		INC=$(head -1 ${FILESDIR}/TW-fonts.scale)
		echo ${ORIGC}+${INC} | bc > tmp
		tail +2 /usr/share/fonts/ttf/zh_TW/fonts.scale >> tmp
		tail +2 ${FILESDIR}/TW-fonts.scale >> tmp
		newins tmp fonts.scale
		rm -f tmp
	else
		newins ${FILESDIR}/TW-fonts.scale fonts.scale	
	fi
}

pkg_postinst() {
	echo ">>> Making big5 font dirs..."
	cd /usr/share/fonts/ttf/zh_TW
	echo ">>> Creating fonts.dir info"
	mkfontdir -e /usr/X11R6/lib/X11/fonts/encodings/large \
	-e /usr/X11R6/lib/X11/fonts/encodings
	echo ">>> Make sure X knows about these font directories!"
	if (  `grep -e "^.*FontPath.*\"/usr/share/fonts/ttf/zh_TW/\"" /etc/X11/XF86Config -q` ); then
		echo "Font path for big5 fonts is listed in /etc/X11/XF86Config."
	else
		echo ">>> You must add /usr/share/fonts/ttf/zh_TW to your font path"
		echo ">>> to be able to use your new Big5 fonts."
	fi

	echo ">>> Restart font server for changes to take effect."
}
