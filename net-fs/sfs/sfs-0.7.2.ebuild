# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/sfs/sfs-0.7.2.ebuild,v 1.2 2003/06/17 22:23:00 wmertens Exp $

DESCRIPTION="SFS (Self-certifying File System) client and server daemons"
HOMEPAGE="http://www.fs.net/"
SRC_URI="http://www.fs.net/sfs/@new-york.lcs.mit.edu,u83s4uk49nt8rmp4uwmt2exvz6d3cavh/pub/sfswww/dist/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
IUSE="ssl"
KEYWORDS="~x86"

DEPEND="virtual/glibc
		>=dev-libs/gmp-4.1
		>=net-fs/nfs-utils-0.3.3
		ssl? ( >=dev-libs/openssl-0.9.6 )"

RDEPEND="$DEPEND
		>=net-nds/portmap-5b-r6"

S="${WORKDIR}/${P}"

pkg_setup() {
	# checking for NFS support *seems* like a good idea, but since
	# nfs-utils doesn't do it, sfs won't either

	# add the sfs user and group if necessary
	enewuser sfs
	enewgroup sfs
}

src_unpack() {
	unpack ${A}

	# Temporary workaround so that it will compile. Remove this on
	# the next version. See bug #22791
	cd ${S}
	sed -i~ 's/-Werror//g' configure
}

src_compile() {
	if [ "`use ssl`" ]; then
		EXTRA_ECONF="${EXTRA_ECONF} --with-openssl=/usr"
	else
		EXTRA_ECONF="${EXTRA_ECONF} --without-openssl"
	fi
	EXTRA_ECONF="${EXTRA_ECONF} --with-gmp=/usr --with-gnuld --prefix=/"

	econf

	# won't parallel build w/o baby-sitting
	EXTRA_EMAKE="${EXTRA_EMAKE} -j1" emake || die
}

src_install() {
	einstall prefix=${D}/

	insinto /etc/sfs/
	doins ${FILESDIR}/sfsrwsd_config

	dodoc AUTHORS COPYING ChangeLog NEWS \
		README README.0.7-upgrade \
		STANDARDS TODO

	exeinto /etc/init.d/
	doexe ${FILESDIR}/sfscd \
		${FILESDIR}/sfssd

	dosym /lib/${P}/newaid /bin/newaid
}

pkg_postinst() {
	einfo "Execute '/etc/init.d/sfscd start' to start the SFS client,"
	einfo "	 or 'rc-update add sfscd default' to add it to the"
	einfo "	 default runlevel."
	einfo ""
	einfo "See the SFS documentation for server configuration."
	einfo ""
	einfo "Both the client and server require kernel support"
	einfo "	 for NFS version 3 in order to operate properly."
	einfo ""

	# Running depscan since we introduced some new init scripts
	/etc/init.d/depscan.sh
	return 0
}

pkg_config() {
	einfo "Generating SFS host key..."
	sfskey gen -P /etc/sfs/sfs_host_key
}
