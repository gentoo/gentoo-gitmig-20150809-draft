# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/cacti-spine/cacti-spine-0.8.7e.ebuild,v 1.1 2009/08/24 16:14:01 ramereth Exp $

inherit autotools

if [[ ${PV} =~ (_p)([0-9]+) ]] ; then
	inherit subversion
	SRC_URI=""
	MTSLPT_REV=${BASH_REMATCH[2]}
	ESVN_REPO_URI="svn://svn.cacti.net/var/svnroot/cacti/spine/branches/0.8.7/@${MTSLPT_REV}"
else
	MY_PV=${PV/_p/-}
	SRC_URI="http://www.cacti.net/downloads/spine/${PN}-${MY_PV}.tar.gz"
fi
DESCRIPTION="Spine is a fast poller for Cacti (formerly known as Cactid)"
HOMEPAGE="http://cacti.net/spine_info.php"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="net-analyzer/net-snmp
	dev-libs/openssl
	virtual/mysql"
RDEPEND="${DEPEND}
	>net-analyzer/cacti-0.8.7"

src_unpack() {
	if [[ "${SRC_URI}" == "" ]] ; then
		subversion_src_unpack
	else
		unpack ${A}
	fi
	cd "${S}"
	sed -i -e 's/^bin_PROGRAMS/sbin_PROGRAMS/' Makefile.am
	rm configure # configure is not executable, autoconf recreates it...
	eautoreconf
}

src_install() {
	dosbin spine || die
	insinto /etc/
	insopts -m0640 -o root
	newins spine.conf spine.conf || die
	dodoc ChangeLog README || die
}

pkg_postinst() {
	ewarn "NOTE: If you upgraded from cactid, do not forgive to setup spine"
	ewarn "instead of cactid through web interface."
	ewarn
	elog "Please see the cacti's site for installation instructions:"
	elog
	elog "http://cacti.net/spine_install.php"
	echo
	ewarn "/etc/spine.conf should be readable by webserver, thus after you"
	ewarn "decide on webserver do not forget to run the following command:"
	ewarn
	ewarn " # chown root:wwwgroup /etc/spine.conf"
	echo
}
