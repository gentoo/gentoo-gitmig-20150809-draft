# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/firebird/firebird-2.0.2.12964.0.ebuild,v 1.1 2007/08/31 04:23:05 wltjr Exp $

inherit flag-o-matic eutils autotools versionator

MY_P=Firebird-$(replace_version_separator 4 -)

DESCRIPTION="A relational database offering many ANSI SQL-99 features"
HOMEPAGE="http://firebird.sourceforge.net/"
SRC_URI="mirror://sourceforge/firebird/${MY_P}.tar.bz2
		 doc? (	ftp://ftpc.inprise.com/pub/interbase/techpubs/ib_b60_doc.zip )"

LICENSE="Interbase-1.0"
SLOT="0"
KEYWORDS="~amd64 -ia64 ~x86"
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

	insinto /opt/firebird
	doins *.msg

	rm -rf "${D}"/opt/firebird/bin/*.sh
	dobin bin/{changeRunUser,restoreRootRunUser,changeDBAPassword}.sh

	insinto /opt/firebird/include
	doins include/*

	insinto /opt/firebird/help
	doins help/help.fdb

	insinto /opt/firebird/upgrade
	doins "${S}"/src/misc/upgrade/v2/*

	insinto /etc/firebird
	insopts -m0644 -o firebird -g firebird
	doins misc/*
	doins ../install/misc/aliases.conf
	insopts -m0660 -o firebird -g firebird
	doins security2.fdb

	exeinto /opt/firebird/UDF
	doexe UDF/*.so
	exeinto /opt/firebird/intl
	doexe intl/*.so
	newexe intl/libfbintl.so fbintl

	diropts -m 755 -o firebird -g firebird
	dodir /var/log/firebird
	dodir /var/run/firebird
	keepdir /var/log/firebird
	keepdir /var/run/firebird

	touch "${D}"/var/log/firebird/firebird.log
	chown firebird:firebird "${D}"/var/log/firebird/firebird.log

	# create links for split config & log file
	dosym /etc/firebird/aliases.conf /opt/firebird/aliases.conf
	dosym /etc/firebird/security2.fdb /opt/firebird/security2.fdb
	dosym /etc/firebird/firebird.conf /opt/firebird/firebird.conf
	dosym /etc/firebird/fbintl.conf /opt/firebird/intl/fbintl.conf
	dosym /var/log/firebird/firebird.log /opt/firebird/firebird.log

	local my_lib=$(get_libdir)

	# firebird has a problem with lib64 dir name, bug?
	if [ ${my_lib} == "lib64" ] ; then
		dosym ./lib64 /opt/firebird/lib
	fi

	# create links for backwards compatibility dosym puts link in / :(
	cd "${D}/opt/firebird/${my_lib}/"
	ln -s libfbclient.so libgds.so
	ln -s libfbclient.so libgds.so.0
	ln -s libfbclient.so libfbclient.so.1

	# create system links for ld
	dosym ../../opt/firebird/${my_lib}/libfbclient.so /usr/${my_lib}/libgds.so
	dosym ../../opt/firebird/${my_lib}/libfbclient.so /usr/${my_lib}/libgds.so.0
	dosym ../../opt/firebird/${my_lib}/libfbclient.so /usr/${my_lib}/libfbclient.so
	dosym ../../opt/firebird/${my_lib}/libfbclient.so.1 /usr/${my_lib}/libfbclient.so.1
	dosym ../../opt/firebird/${my_lib}/libfbclient.so.2 /usr/${my_lib}/libfbclient.so.2

	if use xinetd ; then
		insinto /etc/xinetd.d
		newins "${S}/gen/install/misc/${PN}.xinetd" "${PN}" || die "newins xinetd file failed"
	else
		newinitd "${FILESDIR}/${PN}.init.d" ${PN}
		newconfd "${FILESDIR}/firebird.conf.d" ${PN}
		fperms 640 /etc/conf.d/firebird
	fi
	doenvd "${FILESDIR}/70${PN}"

	# Install docs
	use doc && dodoc "${WORKDIR}"/manuals/*
}

pkg_postinst() {
	# Hack to fix ownership/perms
	chown -fR firebird:firebird /etc/firebird /opt/firebird
	chmod 750 /etc/firebird

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

	# if found /etc/security.gdb from previous install, backup, and restore as
	# /etc/security2.fdb
	if [ -f /etc/firebird/security.gdb ]
	then
		# if we have scurity2.fdb already, back it 1st
		if [ -f /etc/firebird/security2.fdb ] ; then
			cp /etc/firebird/security2.fdb /etc/firebird/security2.fdb.old
		fi
		gbak -B /etc/firebird/security.gdb /etc/firebird/security.gbk
		gbak -R /etc/firebird/security.gbk /etc/firebird/security2.fdb
		mv /etc/firebird/security.gdb /etc/firebird/security.gdb.old
		rm /etc/firebird/security.gbk

		# make sure they are readable only to firebird
		chown firebird:firebird /etc/firebird/{security.*,security2.*}
		chmod 660 /etc/firebird/{security.*,security2.*}

		einfo
		einfo "Converted old security.gdb to security2.fdb, security.gdb has been "
		einfo "renamed to security.gdb.old. if you had previous security2.fdb, "
		einfo "it's backed to security2.fdb.old (all under /etc/firebird)."
		einfo
	fi

	# we need to enable local access to the server
	if [ ! -f /etc/hosts.equiv ] ; then
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
