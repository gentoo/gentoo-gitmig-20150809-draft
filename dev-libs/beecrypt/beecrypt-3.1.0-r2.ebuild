# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/beecrypt/beecrypt-3.1.0-r2.ebuild,v 1.14 2005/04/06 18:45:14 corsair Exp $

inherit flag-o-matic eutils multilib

DESCRIPTION="Beecrypt is a general-purpose cryptography library."
HOMEPAGE="http://sourceforge.net/projects/beecrypt"
SRC_URI="mirror://sourceforge/beecrypt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc s390 sparc x86 ~mips ppc64"
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

	# Athlons are i686
	epatch ${FILESDIR}/beecrypt-3.1.0-athlon.diff
}

src_compile() {
	conf=""
	if ! use amd64; then
		arch=`get-flag march`
		[ -n "$arch" ] && conf="--with-arch=$arch"
		cpu=`get-flag mcpu`
		[ -n "$cpu" ] && conf="$conf --with-cpu=$cpu"
	fi

	econf \
		`use_with python` \
		--enable-shared \
		--enable-static \
		$conf || die
	emake || die "emake failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	# Not needed
	rm -f ${D}/usr/$(get_libdir)/python*/site-packages/_bc.*a
	dodoc BUGS README BENCHMARKS NEWS || die "dodoc failed"
}
