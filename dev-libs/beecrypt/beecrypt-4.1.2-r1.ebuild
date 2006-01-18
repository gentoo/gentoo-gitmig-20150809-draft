# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/beecrypt/beecrypt-4.1.2-r1.ebuild,v 1.1 2006/01/18 23:26:17 vapier Exp $

inherit flag-o-matic eutils multilib autotools

DESCRIPTION="general-purpose cryptography library"
HOMEPAGE="http://sourceforge.net/projects/beecrypt"
SRC_URI="mirror://sourceforge/beecrypt/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="java mmx nocxx python sse sse2 threads"

DEPEND="python? ( >=dev-lang/python-2.2 )
	!<app-arch/rpm-4.2.1"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Set correct python libdir on multilib systems
	sed -i -e 's:get_python_lib():get_python_lib(1,0):' \
		configure.ac || die "sed failed"

	epatch "${FILESDIR}"/${P}-custom-cflags.patch
	eautoreconf
}

src_compile() {
	local myarch=$(get-flag march)
	[[ -z ${myarch} ]] && myarch=${CHOST%%-*}

	use mmx && append-flags -DOPTIMIZE_MMX
	use sse && append-flags -DOPTIMIZE_SSE
	use sse2 && append-flags -DOPTIMIZE_SSE2

	econf \
		$(use_enable threads) \
		$(use_with !nocxx cplusplus) \
		$(use_with java) \
		$(use_with python) \
		--with-arch=${myarch} \
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
