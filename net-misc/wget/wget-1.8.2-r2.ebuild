# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/wget/wget-1.8.2-r2.ebuild,v 1.6 2003/05/20 00:59:52 kumba Exp $


IUSE="ssl nls static ipv6"

inherit gnuconfig

NPVER=20011209
S=${WORKDIR}/${P}
DESCRIPTION="Network utility to retrieve files from the WWW"
HOMEPAGE="http://www.cg.tuwien.ac.at/~prikryl/wget.html"
SRC_URI="mirror://gnu/wget/${P}.tar.gz
	http://www.biscom.net/~cade/away/wget-new-percentage/wget-new-percentage-cvs-${NPVER}.tar.gz
	ipv6? mirror://gentoo/${P}-ipv6-debian.patch.bz2"

RDEPEND="ssl? ( >=dev-libs/openssl-0.9.6b )"
DEPEND="nls? ( sys-devel/gettext )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc alpha hppa arm ~mips"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p1 < ${FILESDIR}/${PF}-gentoo.diff || die

	cd ${S}/src
	patch -p0 < ${WORKDIR}/wget-new-percentage/wnp-20011208-2.diff || die

	if use ipv6
	then
		cd ${S}
		patch -p1 < ${WORKDIR}/${P}-ipv6-debian.patch || die
	fi
}

src_compile() {

	# Make wget use up-to-date configure scripts
	gnuconfig_update

	local myconf
	use nls || myconf="--disable-nls"
	use ssl && myconf="${myconf} --with-ssl"
	use ssl || myconf="${myconf} --without-ssl --disable-opie --disable-digest"
	[ -z "$DEBUG" ] && myconf="${myconf} --disable-debug"
	use ssl && CFLAGS="${CFLAGS} -I/usr/include/openssl"
	./configure --prefix=/usr --sysconfdir=/etc/wget \
		--infodir=/usr/share/info --mandir=usr/share/man $myconf || die
	if use static; then
		make LDFLAGS="--static" || die
	else
		make || die
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
