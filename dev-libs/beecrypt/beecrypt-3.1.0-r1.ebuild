# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/beecrypt/beecrypt-3.1.0-r1.ebuild,v 1.2 2003/11/12 04:28:44 agriffis Exp $

DESCRIPTION="Beecrypt is a general-purpose cryptography library."
HOMEPAGE="http://sourceforge.net/projects/beecrypt"
SRC_URI="mirror://sourceforge/beecrypt/${P}.tar.gz"

LICENSE="LGPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
SLOT="0"

DEPEND="python? ( =dev-lang/python-2.2* )
		!<app-arch/rpm-4.2.1
		alpha? ( sys-devel/autoconf )"

IUSE="python"

src_unpack() {
	unpack ${A}
	cd ${S}

	if use alpha; then
		# Prevent usage of lib64 on alpha where it isn't appropriate.
		# We only have one execution model, so all libraries install
		# in /usr/lib.  (11 Nov 2003 agriffis)
		epatch ${FILESDIR}/beecrypt-3.1.0-alpha.patch
		autoconf
	fi
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
	dodoc BUGS README BENCHMARKS NEWS || die "dodoc failed"
}
