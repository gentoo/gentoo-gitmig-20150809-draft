# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/cfengine/cfengine-3.0.4.ebuild,v 1.4 2010/08/29 10:57:19 idl0r Exp $

EAPI="2"

inherit eutils

MY_PV="${PV//_beta/b}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="An automated suite of programs for configuring and maintaining
Unix-like computers"
HOMEPAGE="http://www.cfengine.org/"
SRC_URI="http://www.cfengine.org/tarballs/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="~amd64 ~arm ~ppc ~s390 ~sparc ~x86"
IUSE="mysql postgres selinux vim-syntax"

DEPEND=">=sys-libs/db-4
	>=dev-libs/openssl-0.9.7
	dev-libs/libpcre
	mysql? ( virtual/mysql )
	postgres? ( dev-db/postgresql-base )
	app-portage/portage-utils"
RDEPEND="${DEPEND}"
PDEPEND="vim-syntax? ( app-vim/cfengine-syntax )"
S="${WORKDIR}/${MY_P}"

src_configure() {
	local myconf

	if use mysql || use postgres ; then
		myconf="--with-sql"
	else
		myconf="--without-sql"
	fi
	# selinux incorrectly enables if it sets --disable-selinux
	if use selinux ; then
		myconf="${myconf} $(use_enable selinux)"
	fi

	# Enforce /var/cfengine for historical compatibility
	econf \
		"${myconf}" \
		--with-workdir=/var/cfengine \
		--docdir=/usr/share/doc/"${P}" \
		--with-berkeleydb=/usr || die

	# Fix Makefile to skip inputs
	sed -i -e 's/\(SUBDIRS.*\) inputs/\1/' Makefile
	sed -i -e 's/\(install-data-am.*\) install-docDATA/\1/' Makefile
	# Fix Makefiles to install tests in correct directory
	for i in file_masters file_operands units ; do
		sed -i -e "s/\(docdir.*\) =.*/\1 = \/usr\/share\/doc\/${P}\/tests\/${i}/" \
			tests/${i}/Makefile
	done
}

src_install() {
	newinitd "${FILESDIR}"/cf-serverd.rc6 cf-servd
	newinitd "${FILESDIR}"/cf-monitord.rc6 cf-monitord
	newinitd "${FILESDIR}"/cf-execd.rc6 cf-execd

	make DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog README TODO INSTALL

	# Manually install inputs
	docinto examples
	dodoc inputs/*.cf

	# Create cfengine working directory
	mkdir -p "${D}"/var/cfengine
	fperms 700 /var/cfengine
	keepdir /var/cfengine/bin
	keepdir /var/cfengine/inputs
}

pkg_postinst() {
	# Copy cfagent into the cfengine tree otherwise cfexecd won't
	# find it. Most hosts cache their copy of the cfengine
	# binaries here. This is the default search location for the
	# binaries.

	cp -f /usr/sbin/cf-{agent,serverd,execd} "${ROOT}"/var/cfengine/bin/

	einfo
	einfo "Init scripts for cf-serverd, cf-monitord, and cf-execd are provided."
	einfo
	einfo "To run cfengine out of cron every half hour modify your crontab:"
	einfo "0,30 * * * *    /usr/sbin/cf-execd -F"
	einfo

	elog "You MUST generate the keys for cfengine by running:"
	elog "emerge --config ${CATEGORY}/${PN}"
}

pkg_config() {
	if [ "${ROOT}" == "/" ]; then
		if [ ! -f "/var/cfengine/ppkeys/localhost.priv" ]; then
			einfo "Generating keys for localhost."
			/usr/sbin/cf-key
		fi
	else
		die "cfengine cfkey does not support any value of ROOT other than /."
	fi
}
