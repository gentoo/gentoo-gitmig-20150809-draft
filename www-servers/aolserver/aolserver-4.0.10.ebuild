# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-servers/aolserver/aolserver-4.0.10.ebuild,v 1.6 2006/08/17 04:20:24 wormo Exp $

inherit eutils

IUSE="nptl"

DESCRIPTION="Webserver with Tcl page scripting"
HOMEPAGE="http://www.aolserver.com/"
SRC_URI="mirror://sourceforge/aolserver/${P}-src.tar.gz"

LICENSE="MPL-1.1"
SLOT="0"
KEYWORDS="~ppc ~x86"

DEPEND=">=dev-lang/tcl-8.4.3"

ns_host="ns-localhost"
ns_etc=/etc/${PN}
ns_pageroot=/var/www/${ns_host}
ns_serverroot=/var/${PN}
ns_lib=/usr/lib/${PN}/lib
ns_bin=/usr/lib/${PN}/bin
ns_mod=/usr/lib/${PN}/modules
ns_data=/usr/share/${PN}
ns_conf=/usr/share/${PN}/include
ns_doc=/usr/share/doc/${P}
ns_include=/usr/include/${PN}
ns_pid=/var/run/${PN}
ns_log=/var/log/${PN}

ns_inst_bins="nsd/nsd
	      nsthread/nsthreadtest"
ns_inst_libs="nsd/libnsd.so
	      nsthread/libnsthread.so
	      nsdb/libnsdb.so
	      nsext/libnsext.so"
ns_inst_alibs="nspd/libnspd.a"
ns_inst_mods="nslog/nslog.so
	      nsperm/nsperm.so
	      nsdb/nsdb.so
	      nsext/nsext.so
	      nscgi/nscgi.so
	      nssock/nssock.so
	      nscp/nscp.so"
ns_inst_includes="nsd/*.h include/*.h"
ns_inst_docs="ChangeLog
	README
	sample-config.tcl"

check_tcl_threads() {

	if ! built_with_use dev-lang/tcl threads;
	then
		echo
		eerror
		eerror "dev-lang/tcl was not merged with threading enabled."
		eerror "please re-emerge dev-lang/tcl with USE=threads"
		eerror
		die "threading not enabled in dev-lang/tcl"
	fi

}

pkg_setup() {

	check_tcl_threads

	enewgroup aolserver
	enewuser aolserver -1 -1 ${ns_data} aolserver
}

src_unpack() {

	unpack ${A}
	find ${S} -type d -name CVS -prune | xargs rm -rf

	if use nptl; then
		epatch ${FILESDIR}/${PV}/aolserver-${PV}-nptl.patch
	fi
}

src_compile() {

	local myconf
	myconf="--with-tcl=/usr/lib"

	econf ${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {

	dodir ${ns_etc}
	dodir ${ns_pageroot}
	dodir ${ns_serverroot}
	dodir ${ns_lib}
	dodir ${ns_bin}
	dodir ${ns_mod}
	dodir ${ns_mod}/tcl
	dodir ${ns_data}
	dodir ${ns_conf}
	dodir ${ns_doc}
	dodir ${ns_include}
	dodir ${ns_pid}
	dodir ${ns_log}
	dodir /var/run/aolserver
	keepdir /var/run/aolserver

	chown -R root:aolserver ${D}/${ns_data}
	chmod -R g+w ${D}/${ns_data}
	chown -R aolserver:aolserver ${D}/${ns_pageroot}
	chmod -R g+w ${D}/${ns_pageroot}
	chown -R aolserver:aolserver ${D}/${ns_serverroot}
	chmod -R g+w ${D}/${ns_serverroot}
	chown -R aolserver:aolserver ${D}/${ns_log}
	chmod -R g+w ${D}/${ns_log}
	chown -R aolserver:aolserver ${D}/${ns_pid}
	chmod -R g+w ${D}/${ns_pid}
	chown -R root:aolserver ${D}/${ns_mod}
	chmod -R g+w ${D}/${ns_mod}
	chown aolserver:aolserver ${D}/var/run/aolserver
	chmod 750 ${D}/var/run/aolserver

	for bin_file in ${ns_inst_bins}; do
		dobin ${S}/${bin_file}
	done

	insinto ${ns_lib}
	for lib_file in ${ns_inst_libs}; do
		doins ${S}/${lib_file}
	done
	for alib_file in ${ns_inst_alibs}; do
		ranlib ${S}/${alib_file}
		doins ${S}/${alib_file}
	done

	insinto ${ns_bin}
	for mod_file in ${ns_inst_mods}; do
		doins ${S}/${mod_file}
	done

	insinto ${ns_include}
	for include_file in ${ns_inst_includes}; do
		doins ${S}/${include_file}
	done

	for doc_file in ${ns_inst_docs}; do
		dodoc ${doc_file}
	done

	doman ${S}/doc/*.1 ${S}/doc/*.3 ${S}/doc/*.n

	insinto ${ns_mod}/tcl
	doins ${S}/tcl/*.tcl

	#doins doesn't recurse
	#insinto ${ns_pageroot}; doins -r ${S}/tests/*
	cp -r ${S}/tests/* ${D}/${ns_pageroot}

	insinto ${ns_bin}
	doins ${S}/nsd/init.tcl

	dodir ${ns_mod}/tcl/nsperm
	insinto ${ns_mod}/tcl/nsperm
	doins ${S}/nsperm/*.tcl

	dodir ${ns_etc}/modules/nsperm
	insinto ${ns_etc}/modules/nsperm
	for perm_file in passwd group hosts.allow hosts.deny perms; do
		doins nsperm/${perm_file}
	done

	insinto ${ns_conf}
	doins ${FILESDIR}/${PV}/Makefile.global
	newins ${S}/include/Makefile.global Makefile.global.orig
	doins ${S}/include/Makefile.build
	dosed "s:../include:${ns_conf}:g" /usr/share/aolserver/include/Makefile.build
	doins ${S}/include/Makefile.module
	dosed "s:../include:${ns_conf}:g" /usr/share/aolserver/include/Makefile.module

	insinto ${ns_etc}
	newins ${FILESDIR}/${PV}/config.tcl aolserver.tcl

	exeinto /etc/init.d
	newexe ${FILESDIR}/${PV}/aolserver.init aolserver
	chmod 750 ${D}/etc/init.d/aolserver
}

pkg_postinst () {

	echo
	einfo "Upgrading:"
	einfo "  Check /usr/share/doc/${PF}/sample-config.tcl.gz"
	einfo "  for new configuration options that you may want"
	einfo "  to use in your existing configuration."
	echo

	ewarn "Group and user settings for ${PN} have changed since"
	ewarn "version 4.0.9. If you are upgrading from <= 4.0.9 it is"
	ewarn "highly recommended you update your ${PN} user and group"
	ewarn "settings. This can be done by running:"
	ewarn "emerge --config =${CATEGORY}/${PF}"
	ewarn "If this is your first install of ${PN}, you can safely"
	ewarn "ignore this message."
	echo
}

pkg_config() {

	if [ -n "`egetent group web`" ]
	then
		ebegin "Replacing group 'web' with 'aolserver'"
			# we already added the aolserver group earlier,
			# so just remove the old web group.
			groupdel web
		eend $?
	fi

	if [ -n "`egetent passwd aolserver`" ]
	then
		ebegin "Updating user 'aolserver'"
			userdel aolserver
			enewuser aolserver -1 -1 ${ns_data} aolserver
		eend $?
	fi
}
