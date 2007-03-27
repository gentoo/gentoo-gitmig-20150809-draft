# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/net-snmp/net-snmp-5.3.1.ebuild,v 1.2 2007/03/27 20:12:21 jokey Exp $

inherit fixheadtails flag-o-matic perl-module

DESCRIPTION="Software for generating and retrieving SNMP data"
HOMEPAGE="http://net-snmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="diskio doc elf ipv6 lm_sensors mfd-rewrites minimal perl rpm selinux smux ssl tcpd X"

DEPEND=">=sys-libs/zlib-1.1.4
	ssl? ( >=dev-libs/openssl-0.9.6d )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	rpm? ( app-arch/rpm
		dev-libs/popt
		app-arch/bzip2
	)
	elf? ( dev-libs/elfutils )
	lm_sensors? ( sys-apps/lm_sensors )"

RDEPEND="${DEPEND}
	perl? (
		X? ( dev-perl/perl-tk )
		!minimal? ( dev-perl/TermReadKey )
	)
	selinux? ( sec-policy/selinux-snmpd )"

DEPEND="${DEPEND}
	>=sys-apps/sed-4
	doc? ( app-doc/doxygen )"

src_unpack() {
	unpack ${A}
	cd "${S}"

#	The lm_sensors patch has a memory leak
#	If you can help, please attach a patch to bug 109785

#	if use lm_sensors; then
#		if use x86 || use amd64; then
#			epatch "${FILESDIR}"/${PN}-lm_sensors.patch
#		else
#			eerror "Unfortunatly you are trying to enable lm_sensors support for an unsupported arch."
#			eerror "please check the availability of sys-apps/lm_sensors - if it is available on"
#			eerror "your arch, please file a bug about this."
#			die "lm_sensors patch error: unsupported arch."
#		fi
#	fi

	# bugs 68467 and 68254
	sed -i -e \
		's/^NSC_AGENTLIBS="@AGENTLIBS@"/NSC_AGENTLIBS="@AGENTLIBS@ @WRAPLIBS@"/' \
		net-snmp-config.in || die "sed net-snmp-config.in"
	sed -i -e 's;embed_perl="yes",;embed_perl=$enableval,;' configure.in \
		|| die "sed configure.in failed"
	# Insecure run-path - bug 103776
	sed -i -e 's/\(@(cd perl ; $(MAKE)\)\() ; \\\)/\1 LD_RUN_PATH=\2/g' \
		Makefile.in || die "sed Makefile.in failed"
	# fix access violation in make check
	sed -i -e 's/\(snmpd.*\)-Lf/\1-l/' testing/eval_tools.sh || \
		die "sed eval_tools.sh failed"
	# fix path in fixproc
	sed -i -e 's|\(database_file =.*\)/local\(.*\)$|\1\2|' local/fixproc || \
		die "sed fixproc failed"

	ht_fix_all
}

src_compile() {
	local mibs

	strip-flags

	autoconf || die "autoconf failed"

	mibs="host ucd-snmp/dlmod"
	use smux && mibs="${mibs} smux"
	use lm_sensors && mibs="${mibs} ucd-snmp/lmSensors"
	use diskio && mibs="${mibs} ucd-snmp/diskio"

	econf \
		--with-install-prefix="${D}" \
		--with-sys-location="Unknown" \
		--with-sys-contact="root@Unknown" \
		--with-default-snmp-version="3" \
		--with-mib-modules="${mibs}" \
		--with-logfile="/var/log/net-snmpd.log" \
		--with-persistent-directory="/var/lib/net-snmp" \
		--enable-ucd-snmp-compatibility \
		--enable-shared \
		--with-zlib \
		$(use_enable mfd-rewrites) \
		$(use_enable perl embedded-perl) \
		$(use_enable ipv6) \
		$(use_enable !ssl internal-md5) \
		$(use_with ssl openssl) \
		$(use_with tcpd libwrap) \
		$(use_with rpm) \
		$(use_with rpm bzip2) \
		$(use_with elf) \
		|| die "econf failed"

	emake -j1 || die "emake failed"

	if use perl ; then
		emake perlmodules || die "compile perl modules problem"
	fi

	if use doc ; then
		einfo "Building HTML Documentation"
		make docsdox || die "failed to build docs"
	fi
}

src_test() {
	cd testing
	if ! make test ; then
		echo
		einfo "Don't be alarmed if a few tests FAIL."
		einfo "This could happen for several reasons:"
		einfo "    - You don't already have a working configuration."
		einfo "    - Your ethernet interface isn't properly configured."
		echo
	fi
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	if use perl ; then
		make DESTDIR="${D}" perlinstall || die "make perlinstall failed"
		fixlocalpod

		use X || rm -f "${D}/usr/bin/tkmib"
	else
		rm -f "${D}/usr/bin/mib2c" "${D}/usr/bin/tkmib"
	fi

	dodoc AGENT.txt ChangeLog FAQ INSTALL NEWS PORTING README* TODO
	newdoc EXAMPLE.conf.def EXAMPLE.conf

	use doc && dohtml docs/html/*

	keepdir /etc/snmp /var/lib/net-snmp

	newinitd "${FILESDIR}"/snmpd-5.1.rc6 snmpd || die
	newconfd "${FILESDIR}"/snmpd-5.1.conf snmpd || die

	# snmptrapd can use the same rc script just slightly modified
	sed -e 's/net-snmpd/snmptrapd/g' \
		-e 's/snmpd/snmptrapd/g' \
		-e 's/SNMPD/SNMPTRAPD/g' \
		"${D}"/etc/init.d/snmpd > "${D}"/etc/init.d/snmptrapd || \
			die "failed to create snmptrapd init script"
	chmod 0755 "${D}"/etc/init.d/snmptrapd

	newconfd "${FILESDIR}"/snmptrapd.conf snmptrapd || die

	# Remove everything, keeping only the snmpd, snmptrapd, MIBs, libs, and includes.
	if use minimal; then
		einfo "USE=minimal is set. Cleaning up excess cruft for a embedded/minimal/server only install."
		rm -rf "${D}"/usr/bin/{encode_keychange,snmp{get,getnext,set,usm,walk,bulkwalk,table,trap,bulkget,translate,status,delta,test,df,vacm,netstat,inform}}
		rm -rf "${D}"/usr/share/snmp/snmpconf-data "${D}"/usr/share/snmp/*.conf
		rm -rf "${D}"/usr/bin/{fixproc,traptoemail} "${D}"/usr/bin/snmpc{heck,onf}
		find "${D}" -name '*.pl' -exec rm -f '{}' \;
		use ipv6 || rm -rf "${D}"/usr/share/snmp/mibs/IPV6*
	fi

	# bug 113788, install example config
	insinto /etc/snmp
	newins "${S}"/EXAMPLE.conf snmpd.conf.example
}

pkg_postinst() {
	einfo "An example configuration file has been installed in"
	einfo "/etc/snmp/snmpd.conf.example."
}

