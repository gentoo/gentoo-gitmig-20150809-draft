# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-2.2.8-r1.ebuild,v 1.2 2008/12/05 08:25:52 robbat2 Exp $

inherit eutils

DESCRIPTION="An automated suite of programs for configuring and maintaining
Unix-like computers"
HOMEPAGE="http://www.cfengine.org/"
SRC_URI="http://www.cfengine.org/downloads/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sparc ~x86"
IUSE=""

DEPEND=">=sys-libs/db-4
	>=dev-libs/openssl-0.9.7
	app-portage/portage-utils"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${PN}-2.2-package-locking-fixup.patch
}

src_compile() {
	# Enforce /var/cfengine for historical compatibility
	econf \
		--with-workdir=/var/cfengine \
		--with-berkeleydb=/usr || die

	# Fix Makefile to skip doc,inputs, & contrib install to wrong locations
	sed -i -e 's/\(DIST_SUBDIRS.*\) contrib inputs doc/\1/' Makefile
	sed -i -e 's/\(SUBDIRS.*\) contrib inputs/\1/' Makefile
	sed -i -e 's/\(install-data-am.*\) install-docDATA/\1/' Makefile

	# Fix man pages
	sed -i -e 's/\/usr\/local/\/usr/' doc/*.8

	emake || die
}

src_install() {
	newinitd "${FILESDIR}"/cfservd.rc6 cfservd
	newinitd "${FILESDIR}"/cfenvd.rc6 cfenvd
	newinitd "${FILESDIR}"/cfexecd.rc6 cfexecd

	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO INSTALL

	# Manually install doc and inputs
	doman doc/*.8
	docinto examples
	dodoc inputs/*.example

	# Create cfengine working directory
	mkdir -p "${D}"/var/cfengine
	fperms 700 /var/cfengine
	keepdir /var/cfengine/bin
	keepdir /var/cfengine/inputs
	dodir /var/cfengine/modules
}

pkg_postinst() {
	# Copy cfagent into the cfengine tree otherwise cfexecd won't
	# find it. Most hosts cache their copy of the cfengine
	# binaries here. This is the default search location for the
	# binaries.

	cp -f /usr/sbin/cf{agent,servd,execd} "${ROOT}"/var/cfengine/bin/

	einfo
	einfo "NOTE: The cfportage module has been deprecated in favor of the"
	einfo "      upstream 'packages' action."
	einfo
	einfo "Init scripts for cfservd, cfenvd, and cfexecd are now provided."
	einfo
	einfo "To run cfengine out of cron every half hour modify your crontab:"
	einfo "0,30 * * * *    /usr/sbin/cfexecd -F"
	einfo
	
	elog "You MUST generate the keys for cfengine by running:"
	elog "emerge --config ${CATEGORY}/${PN}"
}

pkg_config() {
	if [ "${ROOT}" == "/" ]; then
		if [ ! -f "/var/cfengine/ppkeys/localhost.priv" ]; then
			einfo "Generating keys for localhost."
			/usr/sbin/cfkey
		fi
	else
		die "cfengine cfkey does not support any value of ROOT other than /."
	fi
}
