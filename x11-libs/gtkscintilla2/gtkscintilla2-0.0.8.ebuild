# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/gtkscintilla2/gtkscintilla2-0.0.8.ebuild,v 1.7 2009/05/05 07:45:43 ssuominen Exp $

MY_P=GtkScintilla2-${PV}
DESCRIPTION="Gtk-2 wrappers for the Scintilla source editing components."
HOMEPAGE="http://www.gphpedit.org/"
SRC_URI="http://gphpedit.org/releases/${MY_P}.tar.gz"

IUSE=""
SLOT="0"
KEYWORDS="x86 amd64"
LICENSE="GPL-2"

RDEPEND=">=x11-libs/gtk+-2.0"
DEPEND=">=dev-util/pkgconfig-0.12.0
	>=dev-lang/python-2.2
	${RDEPEND}"

S=${WORKDIR}/${MY_P}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# some quick touches to the Makefile, bump the version
	# and make use of our CFLAGS
	cp Makefile Makefile.orig
	sed -e "/VERSION/s/0.0.3/${PV}/" \
		-e "/CFLAGS/s/-g/${CFLAGS} -fPIC/" < Makefile.orig > Makefile

	# and again, in the scintilla part
	cd "${S}"/scintilla/gtk
	cp makefile makefile.orig
	sed -e "/CXXFLAGS/s/-Os/${CFLAGS} -fPIC/" < makefile.orig > makefile

}

src_compile() {
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc README
}
