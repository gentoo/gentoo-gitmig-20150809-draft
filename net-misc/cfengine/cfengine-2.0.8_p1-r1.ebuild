# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-2.0.8_p1-r1.ebuild,v 1.2 2003/10/04 23:24:47 klieber Exp $ 

PARCH=${P/_/}
DESCRIPTION="An agent/software robot and a high level policy language for building expert systems to administrate and configure large computer networks"
HOMEPAGE="http://www.iu.hio.no/cfengine/"
SRC_URI="ftp://ftp.iu.hio.no/pub/cfengine/${PARCH}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc"

DEPEND="virtual/glibc
		>=sys-libs/db-3.2
		>=dev-libs/openssl-0.9.6k"

S="${WORKDIR}/${PARCH}"

src_compile() {
	econf \
		--sysconfdir=/etc/cfengine \
		--localstatedir=/var/lib/cfengine \
		--with-workdir=/var/cfengine \
		--with-berkeleydb=/usr || die

	# Fix Makefile to skip docs install to wrong locations
	cp Makefile Makefile.orig
	sed 's/\(SUBDIRS.*\) inputs doc/\1/' Makefile.orig > Makefile

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING DOCUMENTATION README TODO
	doinfo doc/*.info*
	dohtml doc/*.html
	dodoc inputs/*.example

	mkdir -p ${D}/var/cfengine
	fperms 700 /var/cfengine
	keepdir /var/cfengine/bin
	keepdir /var/cfengine/inputs
}

pkg_postinst() {
	if [ ! -f "/var/cfengine/ppkeys/localhost.priv" ]
		then
		einfo "Generating keys for localhost."
		/usr/sbin/cfkey
	fi

	ln -sf /usr/sbin/cfagent /var/cfengine/bin/cfagent
}
