# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/ndtpd/ndtpd-3.1.5.ebuild,v 1.5 2004/01/03 16:19:43 usata Exp $

inherit eutils

IUSE=""

DESCRIPTION="A server for accessing CD-ROM books with NDTP(Network Directory Transfer Protocol)"
HOMEPAGE="http://www.sra.co.jp/people/m-kasahr/ndtpd/"
SRC_URI="ftp://ftp.sra.co.jp/pub/net/ndtp/ndtpd/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.57"
RDEPEND=">=dev-libs/eb-3
	>=sys-libs/zlib-1.1.3-r2"

src_unpack() {

	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-eb4-gentoo.diff
}

src_compile() {

	autoreconf || die

	econf --with-eb-conf=/etc/eb.conf || die
	emake || die
}

src_install() {

	einstall || die

	# getent doesn't exist on FreeBSD system
	if ! $(cut -d':' -f3 /etc/group | grep 402 >/dev/null 2>&1) ; then
		enewgroup ndtpgrp 402
	else
		enewgroup ndtpgrp
	fi

	if ! $(cut -d':' -f3 /etc/passwd | grep 402 >/dev/null 2>&1) ; then
		enewuser ndtpuser 402 /bin/false /usr/share/dict ndtpgrp
	else
		enewuser ndtpuser -1 /bin/false /usr/share/dict ndtpgrp
	fi

	if ! $(grep 2010/tcp /etc/services >/dev/null 2>&1) ; then
		cp /etc/services ${T}/services
		cat >>${T}/services<<-EOF
		ndtp		2010/tcp			# Network Dictionary Transfer Protocol
		EOF
		insinto /etc
		doins ${T}/services
	fi

	exeinto /etc/init.d
	newexe ${FILESDIR}/ndtpd.initd ndtpd

	insinto /etc
	newins ndtpd.conf{.sample,}

	keepdir /var/lib/ndtpd
	fowners ndtpuser.ndtpgrp /var/lib/ndtpd
	fperms 4710 /var/lib/ndtpd

	dodoc AUTHORS ChangeLog* INSTALL* NEWS README* UPGRADE*
}
