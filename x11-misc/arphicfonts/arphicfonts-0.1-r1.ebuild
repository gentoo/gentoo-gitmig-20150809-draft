# Copyrigth 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
#/space/gentoo/cvsroot/gentoo-x86/x11-misc/arphicfonts/arphicfonts.ebuild

DESCRIPTION="Arphic Fonts"
SRC_URI="ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bkai00mp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/bsmi00lp.ttf.gz
	 ftp://ftp.gnu.org/non-gnu/chinese-fonts-truetype/gbsn00lp.ttf.gz"
HOMEPAGE="http://www.arphic.com.tw/"
LICENSE="Arphic"
SLOT="0"
KEYWORDS="x86"
S=${WORKDIR}

DEPEND="virtual/x11
	x11-misc/ttmkfdir"
RDEPEND=${DEPEND}

src_install() {
	cd ${S}
	insopts -m0644
	insinto /usr/share/fonts/ttf/zh_TW
	doins b*.ttf
	newins ${FILESDIR}/TW-fonts.scale fonts.scale	
	insinto /usr/share/fonts/ttf/zh_CN
	doins g*.ttf
	newins ${FILESDIR}/CN-fonts.scale fonts.scale  

#	These don't get downloaded because there is no simple way to
#	fetch them.. ie if I included the README in SRC_URI above, it would
#	get saved as /usr/portage/distfiles/README which doesn't seem like
#	a really good idea.
#	dodoc LICENSE README
}

pkg_postinst() {
	echo ">>> Making big5 font dirs..."
	cd /usr/share/fonts/ttf/zh_TW
	echo ">>> Creating fonts.dir info"
	mkfontdir -e /usr/X11R6/lib/X11/fonts/encodings/large \
	-e /usr/X11R6/lib/X11/fonts/encodings
	echo ">>> Making gb2312 font dirs..."
	cd /usr/share/fonts/ttf/zh_CN
	echo ">>> Creating fonts.dir info"
	mkfontdir -e /usr/X11R6/lib/X11/fonts/encodings/large \
	-e /usr/X11R6/lib/X11/fonts/encodings
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
