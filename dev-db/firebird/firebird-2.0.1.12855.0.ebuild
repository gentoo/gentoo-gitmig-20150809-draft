# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/firebird/firebird-2.0.1.12855.0.ebuild,v 1.1 2007/05/11 15:49:53 drizzt Exp $

inherit flag-o-matic eutils autotools versionator

MY_P=Firebird-$(replace_version_separator 4 -)

DESCRIPTION="A relational database offering many ANSI SQL-99 features"
HOMEPAGE="http://firebird.sourceforge.net/"
SRC_URI="mirror://sourceforge/firebird/${MY_P}.tar.bz2
		 doc? (	ftp://ftpc.inprise.com/pub/interbase/techpubs/ib_b60_doc.zip )"

LICENSE="Interbase-1.0"
SLOT="0"
KEYWORDS="~amd64 -ia64 ~sparc ~x86"
IUSE="doc xinetd examples debug"
RESTRICT="userpriv"

RDEPEND="dev-libs/libedit
	dev-libs/icu"
DEPEND="${RDEPEND}
	doc? ( app-arch/unzip )"
RDEPEND="${RDEPEND}
	xinetd? ( virtual/inetd )"


S="${WORKDIR}/${MY_P}"

pkg_setup() {
	enewgroup firebird 450
	enewuser firebird 450 /bin/bash /opt/firebird firebird
}

src_unpack() {
	if use doc; then
		# Unpack docs
		mkdir "${WORKDIR}/manuals"
		cd "${WORKDIR}/manuals"
		unpack ib_b60_doc.zip
		cd "${WORKDIR}"
	fi

	unpack "${MY_P}.tar.bz2"

	cd "${S}"

	epatch "${FILESDIR}/${P}-external-libs.patch"
	epatch "${FILESDIR}/${P}-make-deps.patch"
	find "${S}" -name \*.sh -print0 | xargs -0 chmod +x
	rm -rf "${S}"/extern/{editline,icu}

	eautoreconf
}

src_compile() {
	filter-flags -fprefetch-loop-arrays
	filter-mfpmath sse

	econf \
		--prefix=/opt/firebird --with-editline \
		$(use_enable !xinetd superserver) \
		$(use_enable debug) \
		${myconf} || die "econf failed"
	emake -j1 || die "error during make"
}

src_install() {
	cd "${S}/gen/firebird"

	if use examples; then
		docinto examples
		dodoc examples/*
	fi

	into /opt/firebird
	dobin bin/*
	dolib.so lib/*.so*
	dolib.a lib/*.a*

	rm -rf "${D}"/opt/firebird/bin/*.sh
	dobin bin/{changeRunUser,restoreRootRunUser,changeDBAPassword}.sh

	insinto /opt/firebird/include
	doins include/*

	insinto /opt/firebird/help
	doins help/help.fdb

	insinto /etc/firebird
	insopts -m0644 -o firebird -g firebird
	doins misc/*
	insopts -m0660 -o firebird -g firebird
	doins security2.fdb

	exeinto /opt/firebird/UDF
	doexe UDF/*.so
	exeinto /opt/firebird/intl
	doexe intl/*.so

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${S}/gen/install/misc/${PN}.xinetd" "${PN}" || die "newins xinetd file failed"
	else
		# TODO: this sucks, write a new one.
		newinitd "${S}/gen/install/misc/${PN}.init.d.gentoo" "${PN}"
		newconfd "${S}/gen/install/misc/${PN}.conf" "${PN}"
	fi
	doenvd "${FILESDIR}/70${PN}"

	# Install docs
	use doc && dodoc "${WORKDIR}"/manuals/*
}

pkg_postinst() {
	elog
	elog "1. If haven't done so already, please run:"
	elog
	elog "	  \"emerge --config =${PF}\""
	elog
	elog "	  to create lockfiles, set permissions and more"
	elog
	elog "2. Firebird now runs with it's own user. Please remember to"
	elog "	  set permissions to firebird:firebird on databases you "
	elog "	  already have (if any)."
	elog

	if ! use xinetd
	then
		elog "3. You've built the stand alone deamon version,"
		elog "	  SuperServer. If you were using pre 1.5.0 ebuilds"
		elog "	  you're probably have one installed via xinetd. please"
		elog "	  remember to disable it (usually in /etc/xinetd.d/firebird),"
		elog "	  since the current one has it's own init script under"
		elog "	  /etc/init.d"
	fi
}

pkg_config() {
	cd /opt/firebird

	# Create Lock files
	for i in isc_init1 isc_lock1 isc_event1
	do
		FileName=$i.`hostname`
		touch $FileName
		chown firebird:firebird $FileName
		chmod ug=rw,o= $FileName
	done

	# Create log
	if [ ! -h firebird.log ]
	then
		if [ -f firebird.log ]
		then
			mv firebird.log /var/log
		else
			touch /var/log/firebird.log
			chown firebird:firebird /var/log/firebird.log
			chmod ug=rw,o= /var/log/firebird.log
		fi

		# symlink the log to /var/log
		ln -s /var/log/firebird.log firebird.log
	fi

	# if found /etc/isc4.gdb from previous install, backup, and restore as
	# /etc/security.fdb
	if [ -f /etc/firebird/isc4.gdb ]
	then
		# if we have scurity2.fdb already, back it 1st
		if [ -f /etc/firebird/security2.fdb ]
		then
			cp /etc/firebird/security2.fdb /etc/firebird/security2.fdb.old
		fi
		gbak -B /etc/firebird/isc4.gdb /etc/firebird/isc4.gbk
		gbak -R /etc/firebird/isc4.gbk /etc/firebird/security2.fdb
		mv /etc/firebird/isc4.gdb /etc/firebird/isc4.gdb.old
		rm /etc/firebird/isc4.gbk

		# make sure they are readable only to firebird
		chown firebird:firebird /etc/firebird/{isc4.*,security2.*}
		chmod 660 /etc/firebird/{isc4.*,security2.*}

		einfo
		einfo "Converted old isc4.gdb to security.fdb, isc4.gdb has been "
		einfo "renamed to isc4.gdb.old. if you had previous security.fdb, "
		einfo "it's backed to security.fdb.old (all under /etc/firebird)."
		einfo
	fi

	# we need to enable local access to the server
	if [ ! -f /etc/hosts.equiv ]
	then
		touch /etc/hosts.equiv
		chown root:0 /etc/hosts.equiv
		chmod u=rw,go=r /etc/hosts.equiv
	fi

	# add 'localhost.localdomain' to the hosts.equiv file...
	if grep -q 'localhost.localdomain$' /etc/hosts.equiv 2>/dev/null; then
		echo "localhost.localdomain" >> /etc/hosts.equiv
		einfo "Added localhost.localdomain to /etc/hosts.equiv"
	fi

	# add 'localhost' to the hosts.equiv file...
	if grep -q 'localhost$' /etc/hosts.equiv 2>/dev/null; then
		echo "localhost" >> /etc/hosts.equiv
		einfo "Added localhost to /etc/hosts.equiv"
	fi

	HS_NAME=`hostname`
	if grep -q ${HS_NAME} /etc/hosts.equiv 2>/dev/null; then
		echo "${HS_NAME}" >> /etc/hosts.equiv
		einfo "Added ${HS_NAME} to /etc/hosts.equiv"
	fi

	einfo "If you're using UDFs, please remember to move them"
	einfo "to /opt/firebird/UDF"
}
