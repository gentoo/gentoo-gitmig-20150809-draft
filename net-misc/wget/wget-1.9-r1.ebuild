# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.9-r1.ebuild,v 1.6 2003/11/27 15:19:49 brad_mssw Exp $

inherit gnuconfig

IUSE="ssl nls static ipv6 debug socks5"

NPVER=20031022
DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="http://www.cg.tuwien.ac.at/~prikryl/wget.html"
SRC_URI="mirror://gnu/wget/${P}.tar.gz
	http://www.episec.com/people/edelkind/patches/wget/${P}+ipvmisc.patch"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha hppa arm mips amd64 ia64"

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )"
DEPEND="nls? ( sys-devel/gettext )
	sys-devel/autoconf"


src_unpack() {
	unpack ${P}.tar.gz
	epatch ${DISTDIR}/${P}+ipvmisc.patch
}

src_compile() {
	# Make wget use up-to-date configure scripts
	gnuconfig_update

	local myconf
	use ssl \
		&& myconf="${myconf} --with-ssl" \
		|| myconf="${myconf} --without-ssl --disable-opie --disable-digest"

	use ssl && CFLAGS="${CFLAGS} -I/usr/include/openssl"

	econf \
		--sysconfdir=/etc/wget \
		`use_enable ipv6` \
		`use_enable nls` \
		`use_enable debug` \
		`use_with socks5 socks` \
		${myconf} || die

	if use static; then
		emake LDFLAGS="--static" || die
	else
		emake || die
	fi
}

src_install() {
	if use build; then
		insinto /usr
		dobin ${S}/src/wget
		return
	fi
	make prefix=${D}/usr sysconfdir=${D}/etc/wget \
		mandir=${D}/usr/share/man infodir=${D}/usr/share/info install || die
	dodoc AUTHORS COPYING ChangeLog MACHINES MAILING-LIST NEWS README TODO
	dodoc doc/sample.wgetrc
}
