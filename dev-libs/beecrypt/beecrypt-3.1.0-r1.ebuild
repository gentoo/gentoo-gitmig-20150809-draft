# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/beecrypt/beecrypt-3.1.0-r1.ebuild,v 1.15 2005/02/17 17:31:30 corsair Exp $

inherit flag-o-matic eutils

DESCRIPTION="Beecrypt is a general-purpose cryptography library."
HOMEPAGE="http://sourceforge.net/projects/beecrypt"
SRC_URI="mirror://sourceforge/beecrypt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha amd64 ia64"
IUSE="python"

DEPEND="python? ( >=dev-lang/python-2.2 )
	!<app-arch/rpm-4.2.1"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use alpha; then
		# Prevent usage of lib64 on alpha where it isn't appropriate.
		# We only have one execution model, so all libraries install
		# in /usr/lib.  Note: This patch modifies configure, not
		# configure.ac, because this package's Makefile is too smart
		# and screws up mpopt.s when configure.ac is modified.
		# (11 Nov 2003 agriffis)
		epatch ${FILESDIR}/beecrypt-3.1.0-alpha.patch
	fi
	# fix for python paths (#39282)
	epatch ${FILESDIR}/beecrypt-3.1.0-python2.3.patch
}

src_compile() {
	econf \
		`use_with python` \
		--enable-shared \
		--enable-static || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	# Not needed
	rm -f ${D}/usr/lib/python*/site-packages/_bc.*a
	dodoc BUGS README BENCHMARKS NEWS
}
