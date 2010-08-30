# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/newt/newt-0.52.12.ebuild,v 1.1 2010/08/30 23:48:52 jer Exp $

EAPI="2"

inherit eutils multilib python

DESCRIPTION="Redhat's Newt windowing toolkit development files"
HOMEPAGE="https://fedorahosted.org/newt/"
SRC_URI="https://fedorahosted.org/releases/n/e/newt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="gpm tcl nls"

RDEPEND="=sys-libs/slang-2*
	>=dev-libs/popt-1.6
	dev-lang/python
	elibc_uclibc? ( sys-libs/ncurses )
	gpm? ( sys-libs/gpm )
	tcl? ( =dev-lang/tcl-8.5* )
	"

DEPEND="${RDEPEND}"

src_prepare() {
	# bug 73850
	if use elibc_uclibc; then
		sed -i -e 's:-lslang:-lslang -lncurses:g' Makefile.in || die
	fi

	sed -i Makefile.in \
		-e 's|-ltcl8.4|-ltcl8.5|g' \
		-e 's|$(SHCFLAGS) -o|$(LDFLAGS) &|g' \
		-e 's|-g -o|$(CFLAGS) $(LDFLAGS) -o|g' \
		-e 's|-shared -o|$(CFLAGS) $(LDFLAGS) &|g' \
		-e 's|instroot|DESTDIR|g' \
		-e 's|	make |	$(MAKE) |g' \
		|| die "sed Makefile.in"
}

src_configure() {
	econf \
		$(use_with gpm gpm-support) \
		$(use_with tcl) \
		$(use_enable nls) || die "econf failed"
}

src_compile() {
	emake PYTHONVERS="$(PYTHON)" || die "emake failed"
}

src_install () {
	emake \
		DESTDIR="${D}" \
		PYTHONVERS="$(PYTHON)" \
		install || die "make install failed"
	dodoc peanuts.py popcorn.py tutorial.sgml
	doman whiptail.1
}
