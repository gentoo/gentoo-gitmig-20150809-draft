# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/webmin/webmin-1.210.ebuild,v 1.8 2005/08/14 10:14:24 hansmi Exp $

IUSE="apache2 pam postgres ssl webmin-minimal"

inherit eutils pam

VM_V="2.60"

DESCRIPTION="Webmin, a web-based system administration interface"
HOMEPAGE="http://www.webmin.com/"
SRC_URI="webmin-minimal? ( mirror://sourceforge/webadmin/${P}-minimal.tar.gz )
	 !webmin-minimal? ( mirror://sourceforge/webadmin/${P}.tar.gz
	                   http://www.webmin.com/download/virtualmin/virtual-server-${VM_V}.wbm.gz )"

LICENSE="BSD"
SLOT="0"

# ~mips removed because of broken deps. Bug #86085
KEYWORDS="~alpha amd64 hppa ppc ppc64 s390 sparc x86"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	 pam? ( virtual/pam )
	 ssl? ( dev-perl/Net-SSLeay )
	 postgres? ( dev-perl/DBD-Pg )
	 dev-perl/XML-Generator"

src_unpack() {
	unpack ${A}

	cd ${S}

	# in webmin-minimal webalizer and apache2 are not present
	if ! use webmin-minimal ; then
		# Bug #47020
		epatch ${FILESDIR}/${PN}-1.130-webalizer.patch

		# Bug #50810, #51943
		if use apache2; then
			epatch ${FILESDIR}/${PN}-1.140-apache2.patch
		fi

		# Postfix should modify the last entry of the maps file
		epatch ${FILESDIR}/${PN}-1.170-postfix.patch

		mv ${WORKDIR}/virtual-server-${VM_V}.wbm ${T}/vs.tar
		tar -xf ${T}/vs.tar

		# Don't create ${HOME}/cgi-bin on new accounts
		epatch ${FILESDIR}/virtual-server-2.60-nocgibin.patch

		# Check if a newly added IP is already active
		epatch ${FILESDIR}/virtual-server-2.31-checkip.patch

		# Verify Postgres usernames
		epatch ${FILESDIR}/virtual-server-2.31-pgsql.patch

		# Fix some all name virtual items
		epatch ${FILESDIR}/virtual-server-2.31-namevirtual.patch
	fi

	epatch ${FILESDIR}/${PN}-1.170-setup-nocheck.patch
}

src_install() {
	# Bug #97212
	addpredict /var/lib/rpm

	rm -f mount/freebsd-mounts*
	rm -f mount/openbsd-mounts*
	rm -f mount/macos-mounts*

	(find . -name '*.cgi' ; find . -name '*.pl') | perl perlpath.pl /usr/bin/perl -
	dodir /usr/libexec/webmin
	dodir /var

	cp -rp * ${D}/usr/libexec/webmin

	# in webmin-minimal openslp is not present
	if [ ! -f "${D}/usr/libexec/webmin/openslp/config-gentoo-linux" ] ; then
		cp ${D}/usr/libexec/webmin/openslp/config \
			${D}/usr/libexec/webmin/openslp/config-gentoo-linux
	fi

	newinitd ${FILESDIR}/init.d.webmin webmin

	newpamd ${FILESDIR}/webmin-pam webmin
	echo gentoo > ${D}/usr/libexec/webmin/install-type

	# Fix ownership
	chown -R root:0 ${D}

	dodir /etc/webmin
	dodir /var/log/webmin

	config_dir=${D}/etc/webmin
	var_dir=${D}/var/log/webmin
	perl=${ROOT}/usr/bin/perl
	autoos=1
	port=10000
	login=root
	crypt="XXX"
	host=`hostname`
	use ssl && ssl=1 || ssl=0
	atboot=0
	nostart=1
	nochown=1
	autothird=1
	nouninstall=1
	noperlpath=1
	tempdir="${T}"
	export config_dir var_dir perl autoos port login crypt host ssl atboot nostart nochown autothird nouninstall noperlpath tempdir
	${D}/usr/libexec/webmin/setup.sh > ${T}/webmin-setup.out 2>&1 || die "Failed to create initial webmin configuration."

	# Fixup the config files to use their real locations
	sed -i -e 's:^pidfile=.*$:pidfile=/var/run/webmin.pid:' ${D}/etc/webmin/miniserv.conf
	find ${D}/etc/webmin -type f | xargs sed -i -e "s:${D}:${ROOT}:g"

	# Cleanup from the config script
	rm -rf ${D}/var/log/webmin
	keepdir /var/log/webmin/
}

pkg_postinst() {
	local crypt=$(grep "^root:" ${ROOT}/etc/shadow | cut -f 2 -d :)
	crypt=${crypt//\\/\\\\}
	crypt=${crypt//\//\\\/}
	sed -i -e "s/root:XXX/root:${crypt}/" /etc/webmin/miniserv.users

	einfo "To make webmin start at boot time, run: 'rc-update add webmin default'."
	use ssl && einfo "Point your web browser to https://localhost:10000 to use webmin."
	use ssl || einfo "Point your web browser to http://localhost:10000 to use webmin."
}

pkg_prerm() {
	${ROOT}/etc/init.d/webmin stop >& /dev/null
}
