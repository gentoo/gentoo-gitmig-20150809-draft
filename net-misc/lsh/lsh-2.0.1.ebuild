# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lsh/lsh-2.0.1.ebuild,v 1.2 2005/03/18 00:33:31 vapier Exp $

inherit eutils

DESCRIPTION="A GNU implementation of the Secure Shell protocols"
HOMEPAGE="http://www.lysator.liu.se/~nisse/lsh/"
SRC_URI="ftp://ftp.lysator.liu.se/pub/security/lsh/${P}.tar.gz
	http://www.lysator.liu.se/~nisse/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="pam tcpd ipv6 zlib X"

RDEPEND="dev-libs/gmp
	dev-libs/liboop
	dev-libs/nettle
	zlib? ( sys-libs/zlib )
	X? ( virtual/x11 )
	tcpd? ( sys-apps/tcp-wrappers )
	pam? ( sys-libs/pam )"
#	kerberos? ( virtual/krb5 )
DEPEND="${RDEPEND}
	>=sys-apps/portage-2.0.51"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# remove bundled nettle crap #56156 ... this is pretty ugly sed foo,
	# but the alternative is a bigger, uglier patch which would probably 
	# need updating with every version :/
	sed -i -e '/src\/nettle/d' configure || die "sed configure failed"
	sed -i \
		-e '/^SUBDIRS/s:nettle::' \
		-e '/^LDADD/s:nettle/libnettle\.a:-lnettle:' \
		-e 's:nettle/libnettle\.a::' \
		src/Makefile.in || die "sed src failed"
	sed -i \
		-e 's:\.\./\.\./nettle/libnettle\.a::' \
		src/spki/tools/Makefile.in || die "sed spki failed"
	sed -i \
		-e '/^LDADD/s:\.\./nettle/libnettle\.a:-lnettle:' \
		-e 's:\.\./nettle/libnettle\.a::' \
		src/testsuite/Makefile.in || die "sed test failed"
	rm -r src/nettle
}

src_compile() {
	# configure script checks /dev/ptmx in order to enable
	# proper unix pty support ... so lets fake that it works :)
	addpredict /dev/ptmx
#		$(use_enable kerberos)
	econf \
		--disable-kerberos \
		$(use_enable pam) \
		$(use_enable ipv6) \
		$(use_with zlib) \
		$(use_with tcpd tcpwrappers) \
		$(use_with X x) \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake install DESTDIR="${D}" || die "install failed"
	dodoc ANNOUNCE AUTHORS ChangeLog FAQ NEWS README

	newinitd "${FILESDIR}"/lsh.rc lshd
	newconfd "${FILESDIR}"/lsh.confd lshd
}
