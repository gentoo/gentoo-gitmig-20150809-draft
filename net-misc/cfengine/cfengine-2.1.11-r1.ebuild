# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-2.1.11-r1.ebuild,v 1.1 2004/11/01 20:47:03 klieber Exp $

inherit gnuconfig eutils

DESCRIPTION="An agent/software robot and a high level policy language for building expert systems to administrate and configure large computer networks"
HOMEPAGE="http://www.iu.hio.no/cfengine/"
SRC_URI="ftp://ftp.iu.hio.no/pub/cfengine/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~arm ~amd64"
IUSE=""

DEPEND="virtual/libc
	>=sys-libs/db-3.2
	>=dev-libs/openssl-0.9.6k"

src_unpack() {
	unpack ${A}
	cd ${S}
	gnuconfig_update ${S}
}

src_compile() {

	# Enforce /var/cfengine for historical compatibility
	econf \
		--with-workdir=/var/cfengine \
		--with-berkeleydb=/usr || die

	# Fix Makefile to skip doc & inputs install to wrong locations
	sed -i -e 's/\(SUBDIRS.*\) inputs doc/\1/' Makefile

	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS ChangeLog COPYING README TODO

	# Manually install doc and inputs
	doinfo doc/*.info*
	dohtml doc/*.html
	dodoc inputs/*.example

	# Create cfengine working directory
	mkdir -p ${D}/var/cfengine
	fperms 700 /var/cfengine
	keepdir /var/cfengine/bin
	keepdir /var/cfengine/inputs
	dodir /var/cfengine/modules
	cd ${D}/var/cfengine/modules
	tar pjxf ${FILESDIR}/module-cfportage.tbz2
}

pkg_postinst() {
	if [ ! -f "/var/cfengine/ppkeys/localhost.priv" ]
		then
		einfo "Generating keys for localhost."
		/usr/sbin/cfkey
	fi


	# Copy cfagent into the cfengine tree otherwise cfexecd won't
	# find it. Most hosts cache their copy of the cfengine
	# binaries here. This is the default search location for the
	# binaries.

	cp /usr/sbin/cf{agent,servd,execd} /var/cfengine/bin/
}
