# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/skencil/skencil-0.6.18_pre20080519-r1.ebuild,v 1.1 2008/11/21 12:32:58 hanno Exp $

EAPI=2

inherit python multilib eutils

IUSE="nls"
S=${WORKDIR}/${PN}-0.6
DESCRIPTION="Interactive X11 vector drawing program"
SRC_URI="mirror://gentoo/${P}.tar.bz2"
HOMEPAGE="http://www.skencil.org/"
DEPEND="dev-lang/python[tk]
	>=dev-python/imaging-1.1.2-r1
	dev-python/reportlab
	dev-lang/tk
	nls? ( sys-devel/gettext )"
RDEPEND="!elibc_glibc? ( nls? ( sys-devel/gettext ) )
	dev-python/pyxml"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/skencil-configure-without-nls.diff"
	epatch "${FILESDIR}/skencil-0.6.17-setup.py.patch"

	# Fix hardcoded libdir
	sed -i -e "s:lib/:$(get_libdir)/:" \
		-e "s:lib':$(get_libdir)':" \
		"${S}"/{Pax,Filter,Sketch/Modules}/Makefile.pre.in \
		"${S}"/Plugins/Objects/Lib/multilinetext/{TextEditor,styletext}.py \
		"${S}"/setup.py || die "sed failed"
}

src_compile() {
	./setup.py configure `use_with nls` || die
	BLDSHARED='gcc -shared' ./setup.py build || die
}

src_install () {
	./setup.py install --prefix=/usr --dest-dir="${D}"
	assert "setup.py install failed"

	newdoc Pax/README README.pax
	newdoc Filter/README README.filter
	dodoc Examples Doc Misc
	dodoc README INSTALL BUGS CREDITS TODO PROJECTS FAQ NEWS
}
