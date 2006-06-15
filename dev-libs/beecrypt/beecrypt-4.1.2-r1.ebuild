# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/beecrypt/beecrypt-4.1.2-r1.ebuild,v 1.2 2006/06/15 19:55:07 sanchan Exp $

inherit flag-o-matic eutils multilib autotools

DESCRIPTION="general-purpose cryptography library"
HOMEPAGE="http://sourceforge.net/projects/beecrypt"
SRC_URI="mirror://sourceforge/beecrypt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="java nocxx python threads"

DEPEND="python? ( >=dev-lang/python-2.2 )
	!<app-arch/rpm-4.2.1"

src_unpack() {
	ewarn "Due to upstream bug in configure.ac we have to replace the following cpu flags:"
	ewarn "pentium-m -> pentium3"
	ewarn "athlon64 -> k8"
	ewarn "The MMX assembler code presents TEXTREL issues. If you don't want them try using"
	ewarn "relaxed CFLAGS like -march=i686 instead of -march=pentium3 and so on."
	ewarn "This ebuild fails on multilib system with multilib-strict on AMD64."
	ewarn "Feel free to help upstream solving the above bugs."
	unpack ${A}
	cd ${S}
	# Set correct python libdir on multilib systems
	sed -i -e 's:get_python_lib():get_python_lib(1,0):' \
		configure.ac || die "sed failed"

	#upstream patches from CVS
	epatch ${FILESDIR}/${P}-python-Makefile-am.patch
	epatch ${FILESDIR}/${P}-python-debug-py-c.patch
	epatch ${FILESDIR}/${P}-configure-ac.patch
	eautoreconf
}

src_compile() {
	replace-cpu-flags pentium-m pentium3
	replace-cpu-flags athlon64 k8

	local myarch=$(get-flag march)
	[[ -z ${myarch} ]] && myarch=${CHOST%%-*}

	econf \
		$(use_enable threads) \
		$(use_with !nocxx cplusplus) \
		$(use_with java) \
		$(use_with python) \
		--with-arch=${myarch} \
		--libdir=/usr/$(get_libdir) \
		|| die
	emake || die "emake failed"
}

src_test() {
	export BEECRYPT_CONF_FILE=${T}/beecrypt-test.conf
	echo provider.1=${S}/c++/provider/.libs/base.so > ${BEECRYPT_CONF_FILE}
	make check || die "self test failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	# Not needed
	rm -f "${D}"/usr/$(get_libdir)/python*/site-packages/_bc.*a
	dodoc BUGS README BENCHMARKS NEWS || die "dodoc failed"
}
