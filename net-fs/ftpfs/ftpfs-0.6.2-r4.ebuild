# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-fs/ftpfs/ftpfs-0.6.2-r4.ebuild,v 1.1 2003/08/26 03:26:14 vapier Exp $

MY_P=${P}-k2.4
S=${WORKDIR}/${MY_P}
DESCRIPTION="A filesystem for mounting FTP volumes"
HOMEPAGE="http://ftpfs.sourceforge.net/"
SRC_URI="mirror://sourceforge/ftpfs/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc"
IUSE="autofs"

DEPEND="virtual/linux-sources
	autofs? ( net-fs/autofs )"

pkg_setup() {
	check_KV
}

src_unpack() {
	unpack ${A}
	cd ${S}

	[ "${ARCH}" = "ppc" ] && epatch ${FILESDIR}/${P}-makefile-fix.patch
	[ `use autofs` ] && epatch ${FILESDIR}/${P}-autofs-gentoo.patch
	sed -i 's:depmod -aq::g' ftpfs/Makefile
}


src_compile() {
	cd ftpfs
	make || die "make ftpfs failed"
	cd ../ftpmount
	make CFLAGS="${CFLAGS}" || die "make ftpmount failed"
}

src_install() {
	make \
		MODULESDIR=${D}/lib/modules/${KV} \
		FTPMOUNT=${D}/usr/bin/ftpmount \
		install || die
	if [ `use autofs` ] ; then
		make \
			AUTOMOUNTED_FTP_DIR_PORTAGE=${D}/mnt/ftpfs \
			AUTOMOUNT_FILES_PORTAGE=${D}/etc/autofs \
			install_automount || die
	fi

	dodoc CHANGELOG
	dohtml -r docs
}

pkg_postinst() {
	depmod -aq || die "depmod failed"

	if [ `use autofs` ] ; then
		echo
		einfo "To enable autofs functionality, please execute the command"
		einfo " \"TIMEOUT=xx ebuild \\"
		einfo "  /var/db/pkg/net-fs/${PF}/${PF}.ebuild config\""
		einfo " TIMEOUT determines the autofs timeout (--timeout switch)."
		einfo " If you don't provide a TIMEOUT, the --timeout switch won't be"
		einfo " added, i.e. automounted ftp connections show up indefinitely."
		einfo " Consult the manual page of autofs(5) for details."
		echo
	fi
}

pkg_postrm() {
	if [ -f /etc/autofs/auto.master ] && [ -n "`grep ftpfs /etc/autofs/auto.master`" ] ; then
		cp /etc/autofs/auto.master{,.ftpfs}
		grep -v "ftpfs" /etc/autofs/auto.master.ftpfs > /etc/autofs/auto.master
		echo
		einfo "The ftpfs entries have been removed from the autofs configuration"
		einfo " \"/etc/autofs/auto.master\"."
		einfo "A backup containing your previous ftpfs entries has been created as"
		einfo " \"/etc/autofs/auto.master.ftpfs\"."
		echo
		einfo "Don't forget to restart autofs via"
		einfo " \"/etc/init.d/autofs restart\""
	fi
}

pkg_config() {
	if [ -x /etc/autofs/auto.ftp ] ; then
		if [ -z "`grep auto.ftp /etc/autofs/auto.master`" ] ; then
			echo "# Automagically mount ftp shares via ftpfs" >> /etc/autofs/auto.master
			echo -n "/mnt/ftpfs	/etc/autofs/auto.ftp" >> /etc/autofs/auto.master
			[ -n ${TIMEOUT} ] \
				&& echo " --timeout ${TIMEOUT}" >> /etc/autofs/auto.master \
				|| echo >> /etc/autofs/auto.master
		fi

		CHANGED_LINE="`grep auto.ftp /etc/autofs/auto.master`"

		einfo "If you want, you can add further autofs options to the line"
		einfo " \"${CHANGED_LINE}\""
		einfo " in the file"
		einfo " \"/etc/autofs/auto.master\"."
		einfo " Consult the manual page of autofs(5) for details."
		echo
		einfo "Don't forget to issue a"
		einfo " \"/etc/init.d/autofs restart\""
	else
		ewarn "The file"
		ewarn " \"/etc/autofs/auto.ftp\""
		ewarn "could not be found. Nothing has been done!"
	fi
}
