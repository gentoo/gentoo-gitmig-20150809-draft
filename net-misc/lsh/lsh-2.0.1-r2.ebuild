# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/lsh/lsh-2.0.1-r2.ebuild,v 1.6 2007/03/26 08:06:35 antarus Exp $

inherit eutils

DESCRIPTION="A GNU implementation of the Secure Shell protocols"
HOMEPAGE="http://www.lysator.liu.se/~nisse/lsh/"
SRC_URI="ftp://ftp.lysator.liu.se/pub/security/lsh/${P}.tar.gz
	http://www.lysator.liu.se/~nisse/archive/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc sparc x86"
IUSE="pam tcpd ipv6 zlib X"

RDEPEND="dev-libs/gmp
	dev-libs/liboop
	dev-libs/nettle
	zlib? ( sys-libs/zlib )
	X? ( || ( ( x11-libs/libXau ) virtual/x11 ) )
	tcpd? ( sys-apps/tcp-wrappers )
	pam? ( sys-libs/pam )"
#	kerberos? ( virtual/krb5 )
# need guile because the source changes
DEPEND="${RDEPEND}
	dev-scheme/guile"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-fix-fd-leak.patch
	# Rename 'sftp-server' to something that doesn't conflict with openssh
	sed -i \
		-e 's:sftp-server:lsh-sftp-server:' \
		doc/{lshd.8,lsh.info} src/lshd.c src/sftp/sftp-server.[c8] \
		|| die "rename sftp-server"
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
	emake -j1 install DESTDIR="${D}" || die "install failed"
	dodoc ANNOUNCE AUTHORS ChangeLog FAQ NEWS README

	newinitd "${FILESDIR}"/lsh.rc lshd
	newconfd "${FILESDIR}"/lsh.confd lshd

	# cleanup conflicting crap
	mv "${D}"/usr/sbin/{,lsh-}sftp-server || die
	mv "${D}"/usr/share/man/man8/{,lsh-}sftp-server.8
	rm -r "${D}"/usr/share/man/man5
}
