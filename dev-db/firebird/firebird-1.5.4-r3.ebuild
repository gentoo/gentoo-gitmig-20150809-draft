# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/firebird/firebird-1.5.4-r3.ebuild,v 1.2 2007/06/21 05:37:23 wltjr Exp $

inherit flag-o-matic eutils

extra_ver="4910"
MY_P=${P}.${extra_ver}
DESCRIPTION="A relational database offering many ANSI SQL-99 features."
HOMEPAGE="http://firebird.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2
	 mirror://gentoo/firebird-1.5.4-debian-patchset.tar.bz2
		doc? (	http://firebird.sourceforge.net/pdfmanual/Firebird-1.5-QuickStart.pdf
				ftp://ftpc.inprise.com/pub/interbase/techpubs/ib_b60_doc.zip )"

LICENSE="Interbase-1.0"
SLOT="0"
KEYWORDS="~amd64 -ia64 -sparc ~x86"
IUSE="xinetd doc"
RESTRICT="nouserpriv"

RDEPEND="xinetd? ( virtual/inetd )"
DEPEND="${RDEPEND}
	doc? ( app-arch/unzip )"


S="${WORKDIR}"/${MY_P}

pkg_setup() {
	enewgroup firebird 450
	enewuser firebird 450 /bin/bash /opt/firebird firebird
}

src_unpack() {
	if use doc; then
	    # Unpack docs
	    mkdir ${WORKDIR}/manuals
	    cd ${WORKDIR}/manuals
	    unpack ib_b60_doc.zip
	    cd ${WORKDIR}
	fi

	unpack ${MY_P}.tar.bz2
	unpack firebird-1.5.4-debian-patchset.tar.bz2
	cd ${S}

	for p in $(ls ${WORKDIR}/patches) ; do
		epatch ${WORKDIR}/patches/${p} || die "Patch did not apply."
	done

	# This file must be regenerated during build
	rm ${S}/src/dsql/parse.cpp
}

src_compile() {
	# fix bug #33584
	#strip-flags -funroll-loops
	# but Meir intended "filter-flags -funroll-loops"; awaiting bug reports...

	filter-flags -fprefetch-loop-arrays
	filter-mfpmath sse

	local myconf="--prefix=/opt/firebird --with-editline"
	use xinetd || myconf="${myconf} --enable-superserver"

	NOCONFIGURE=1

	./autogen.sh ${myconf} || die "couldn't run autogen.sh"

	find . -type f -exec sed -i -e "s/-lcurses/-lncurses/g" {} \;

	econf ${myconf} || die "./configure failed"
	emake -j 1 || die "error during make"
}

src_install() {
	cd ${S}/gen
	make -f Makefile.install tarfile || die "Can't create buildroot tar file"
	cd ${D}
	tar zxpf ${S}/gen/Firebird?S-*/buildroot.tar.gz

	dodoc ${D}/opt/firebird/{README,WhatsNew,doc/*}
	docinto examples
	dodoc ${D}/opt/firebird/examples/*
	docinto sql.extensions
	dodoc ${D}/opt/firebird/doc/sql.extensions/*

	rm -r ${D}/opt/firebird/{README,WhatsNew,doc,misc}
	rm -r ${D}/opt/firebird/examples

	if use xinetd ; then
		insinto /etc/xinetd.d ; newins ${FILESDIR}/${PN}-1.5.0.xinetd firebird
	else
		exeinto /etc/init.d ; newexe ${FILESDIR}/${PN}.init.d firebird
		insinto /etc/conf.d ; newins ${FILESDIR}/firebird.conf.d firebird
		fperms 640 /etc/conf.d/firebird
	fi
	insinto /etc/env.d ; newins ${FILESDIR}/70${PN} 70firebird

	# Following is adapted from postinstall.sh

	dodir /opt/firebird/run
	keepdir /opt/firebird/run

	# make sure everything is owned by firebird
	chown -R firebird:firebird ${D}/opt/firebird

	# make sure permissions are set
	chmod -R o= ${D}/opt/firebird

	# fix directories
	find ${D}/opt/firebird -print -type d | xargs chmod o=rx

	# set permissions for /bin
	cd ${D}/opt/firebird/bin
	chmod ug=rx,o= *
	chmod a=rx isql qli gpre

	use xinetd && chmod ug=rxs,o= ${D}/opt/firebird/bin/{fb_lock_mgr,gds_drop,fb_inet_server}
	chmod u=rw,go=r ${D}/opt/firebird/{aliases.conf,firebird.conf}
	chmod ug=rw,o= ${D}/opt/firebird/{security.fdb,help/help.fdb}

	for i in include lib UDF intl; do chmod a=r ${D}/opt/firebird/${i}/*; done
	chmod ug=rx,o= ${D}/opt/firebird/{intl/fbintl,UDF/fbudf.so,UDF/ib_udf.so}

	local my_lib=$(get_libdir)

	# firebird has a problem with lib64 dir name, bug?
	if [ ${my_lib} == "lib64" ] ; then
		# tmp fix since stable arch seems to install in lib, not lib64 as ~arch
		if [ -d ${D}/opt/firebird/lib ]; then
			mv ${D}/opt/firebird/lib ${D}/opt/firebird/lib64
		fi
		dosym /opt/firebird/lib64 /opt/firebird/lib
	fi

	# create links for back compatibility
	dosym ../../opt/firebird/${my_lib}/libfbclient.so /usr/${my_lib}/libgds.so
	dosym ../../opt/firebird/${my_lib}/libfbclient.so /usr/${my_lib}/libgds.so.0
	dosym ./libfbclient.so /opt/firebird/${my_lib}/libgds.so
	dosym ./libfbclient.so /opt/firebird/${my_lib}/libgds.so.0

	# we want relative symlinks...
	dosym ../../opt/firebird/${my_lib}/libfbclient.so /usr/${my_lib}/libfbclient.so
	dosym ../../opt/firebird/${my_lib}/libfbclient.so.1 /usr/${my_lib}/libfbclient.so.1
	dosym ../../opt/firebird/${my_lib}/libfbclient.so.1.5.4 /usr/${my_lib}/libfbclient.so.1.5.4

	# move and link config files to /etc/firebird so they'll be protected
	dodir /etc/firebird
	mv ${D}/opt/firebird/{security.fdb,aliases.conf,firebird.conf} ${D}/etc/firebird
	dosym ../../etc/firebird/security.fdb /opt/firebird/security.fdb
	dosym ../../etc/firebird/aliases.conf /opt/firebird/aliases.conf
	dosym ../../etc/firebird/firebird.conf /opt/firebird/firebird.conf

	# Install docs
	if use doc; then
	    dodoc ${DISTDIR}/Firebird-1.5-QuickStart.pdf
	    dodoc ${WORKDIR}/manuals/*
	fi
}

pkg_postinst() {
	elog
	elog "1. If haven't done so already, please run:"
	elog
	elog "   \"emerge --config =${PF}\""
	elog
	elog "   to create lockfiles, set permissions and more"
	elog
	elog "2. Firebird now runs with it's own user. Please remember to"
	elog "   set permissions to firebird:firebird on databases you "
	elog "   already have (if any)."
	elog

	if ! use xinetd
	then
		elog "3. You've built the stand alone deamon version,"
		elog "   SuperServer. If you were using pre 1.5.0 ebuilds"
		elog "   you're probably have one installed via xinetd. please"
		elog "   remember to disable it (usually in /etc/xinetd.d/firebird),"
		elog "   since the current one has it's own init script under"
		elog "   /etc/init.d"
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

	# add gds_db to /etc/services
	if [ -z "`grep gds_db  /etc/services`" ]
	then
		echo -e "#\n#Service added for gds_db (firebird)\n#" >> /etc/services
		echo "gds_db		3050/tcp" >> /etc/services
		einfo "added gds_db to /etc/services"
	fi

	# if found /etc/isc4.gdb from previous install, backup, and restore as
	# /etc/security.fdb
	if [ -f /etc/firebird/isc4.gdb ]
	then
		# if we have scurity.fdb already, back it 1st
		if [ -f /etc/firebird/security.fdb ]
		then
			cp /etc/firebird/security.fdb /etc/firebird/security.fdb.old
		fi
		gbak -B /etc/firebird/isc4.gdb /etc/firebird/isc4.gbk
		gbak -R /etc/firebird/isc4.gbk /etc/firebird/security.fdb
		mv /etc/firebird/isc4.gdb /etc/firebird/isc4.gdb.old
		rm /etc/firebird/isc4.gbk

		# make sure they are readable only to firebird
		chown firebird:firebird /etc/firebird/{isc4.*,security.*}
		chmod 660 /etc/firebird/{isc4.*,security.*}

		elog
		elog "Converted old isc4.gdb to security.fdb, isc4.gdb has been "
		elog "renamed to isc4.gdb.old. if you had previous security.fdb, "
		elog "it's backed to security.fdb.old (all under /etc/firebird)."
		elog
	fi

	# we need to enable local access to the server
	if [ ! -f /etc/hosts.equiv ]
	then
		touch /etc/hosts.equiv
		chown root:0 /etc/hosts.equiv
		chmod u=rw,go=r /etc/hosts.equiv
	fi

	if [ -z "`grep 'localhost$' /etc/hosts.equiv`" ]
	then
		echo "localhost" >> /etc/hosts.equiv
		einfo "Added localhost to /etc/hosts.equiv"
	fi

	HS_NAME=`hostname`
	if [ -z "`grep ${HS_NAME} /etc/hosts.equiv`" ]
	then
		echo "${HS_NAME}" >> /etc/hosts.equiv
		einfo "Added ${HS_NAME} to /etc/hosts.equiv"
	fi

	elog "If you're using UDFs, please remember to move them"
	elog "to /opt/firebird/UDF"
}
