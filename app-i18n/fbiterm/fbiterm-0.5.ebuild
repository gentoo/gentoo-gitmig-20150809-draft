# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/fbiterm/fbiterm-0.5.ebuild,v 1.3 2004/04/06 03:51:19 vapier Exp $

inherit eutils

DESCRIPTION="Framebuffer internationalized terminal emulator"
HOMEPAGE="http://www-124.ibm.com/linux/projects/iterm/"
SRC_URI="http://www-124.ibm.com/linux/projects/iterm/releases/iterm-${PV}.tar.gz"

LICENSE="CPL-0.5"
SLOT="0"
KEYWORDS="~x86"

DEPEND="virtual/x11
	x11-libs/libiterm-mbt
	sys-libs/zlib
	media-fonts/unifont"

S=${WORKDIR}/iterm/unix/fbiterm

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog README*
}

pkg_postinst() {
	einfo
	einfo "1. If you haven't created your locale, run localedef."
	einfo "# localedef -v -c -i en_GB -f UTF-8 en_GB.UTF-8"
	einfo "(If you want to use other locales such as Japanese, replace"
	einfo "en_GB with ja_JP and en_GB.UTF-8 with ja_JP.UTF-8, respectively)"
	einfo
	einfo "2. Set enviroment variable."
	einfo "% export LC_CTYPE=en_GB.UTF-8 (sh, bash, zsh, ...)"
	einfo "> setenv LC_CTYPE en_GB.UTF-8 (csh, tcsh, ...)"
	einfo "(Again, if you want to use Japanese locale, create ja_JP.UTF-8"
	einfo " locale by localedef and set LC_CTYPE to ja_JP.UTF-8)"
	einfo
	einfo "3. Run unicode_start."
	einfo "% unicode_start"
	einfo
	einfo "4. Run fbiterm."
	einfo "% fbiterm"
	einfo
}
