# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pilrc/pilrc-3.2.ebuild,v 1.5 2007/07/12 01:05:42 mr_bones_ Exp $

DESCRIPTION="PalmOS Resource Compiler and Viewer"
HOMEPAGE="http://www.ardiri.com/index.php?redir=palm&cat=pilrc"
SRC_URI="mirror://sourceforge/pilrc/pilrc-${PV}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc sparc x86"
IUSE="gtk"

RDEPEND="gtk? ( =x11-libs/gtk+-1.2* )"

DEPEND="app-arch/unzip
	${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd ${S}
	mkdir fonts
	unzip -d fonts -q contrib/pilfont.zip
}

src_compile() {
	ECONF_SOURCE=unix econf $(use_enable gtk pilrcui)
	emake || die "make failed"

	cd ${S}/fonts; emake || die "fonts make failed"
}

src_install () {
	make DESTDIR=${D} install || die
	dobin fonts/pilfont
	dodoc README.txt LICENSE.txt
	dohtml -r doc/*.html doc/images
	newdoc fonts/README README-pilfont.txt
	use gtk && dobin pilrcui
}
