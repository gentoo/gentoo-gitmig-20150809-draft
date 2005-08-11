# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/beecrypt/beecrypt-4.1.2.ebuild,v 1.2 2005/08/11 12:45:37 herbs Exp $

inherit flag-o-matic eutils multilib

DESCRIPTION="Beecrypt is a general-purpose cryptography library."
HOMEPAGE="http://sourceforge.net/projects/beecrypt"
SRC_URI="mirror://sourceforge/beecrypt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~s390 ~sparc ~x86 ~mips ~ppc64"
IUSE="python"

DEPEND="python? ( >=dev-lang/python-2.2 )
	!<app-arch/rpm-4.2.1"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/beecrypt-4.1.2-athlon.patch
	libtoolize --copy --force

	# Set correct python libdir on multilib systems
	sed -i -e 's:get_python_lib():get_python_lib(1,0):' \
		${S}/configure{.ac,} || die "sed failed"
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

src_test() {
	export BEECRYPT_CONF_FILE=${T}/beecrypt-test.conf
	echo provider.1=${S}/c++/provider/.libs/base.so > ${BEECRYPT_CONF_FILE}
	make check || die "self test failed"
}

src_install() {
	make DESTDIR=${D} install || die "make install failed"
	# Not needed
	rm -f ${D}/usr/$(get_libdir)/python*/site-packages/_bc.*a
	dodoc BUGS README BENCHMARKS NEWS || die "dodoc failed"
}
