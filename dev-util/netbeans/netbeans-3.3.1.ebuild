# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/netbeans/netbeans-3.3.1.ebuild,v 1.3 2002/07/11 06:30:25 drobbins Exp $

MY_P=NetBeansIDE-release331
S=${WORKDIR}/${PN}
DESCRIPTION="Netbeans ${PV} IDE for Java"
SRC_URI="http://www.netbeans.org/download/release33/night/build200202011224/${MY_P}.tar.gz"
HOMEPAGE="http://www.netbeans.org"

RDEPEND=">=virtual/jdk-1.3"

src_unpack() {
	unpack ${A}

	# fix jdkhome references
	cd ${S}/bin
	# rmid_wrapper.sh
	cp rmid_wrapper.sh rmid_wrapper.sh.orig
	sed -e 's:^jdkhome="":jdkhome="`java-config --jdk-home`":' \
		rmid_wrapper.sh.orig >rmid_wrapper.sh
	rm -f rmid_wrapper.sh.orig
	# runide.sh
	cp runide.sh runide.sh.orig
	sed -e 's:^jdkhome="":jdkhome="`java-config --jdk-home`":' \
		runide.sh.orig >runide.sh
	rm -f runide.sh.orig

}

src_install() {
	# remove non-x86 Linux binaries
	rm -f ${S}/bin/runide*.exe ${S}/bin/rmid_wrapper.exe
	rm -f ${S}/bin/runide*.com
	rm -f ${S}/bin/runideos2.cmd
	rm -f ${S}/bin/fastjavac/fastjavac.exe
	rm -f ${S}/bin/fastjavac/fastjavac.sun
	rm -f ${S}/bin/fastjavac/fastjavac.sun.intel
	rm -f ${S}/bin/unsupported/*.bat
	dodir /opt/${P}
	dodoc build_info 
	dohtml CHANGES.html CREDITS.html README.html netbeans.css
	# note: docs/ are docs used internally by the IDE
	cp -Rdp beans bin docs lib modules sources system ${D}/opt/${P}

	# This is a binary-only package. It will only live in /opt -- karltk
	# dodir /usr/bin
	# dosym /opt/${P}/bin/runide.sh /usr/bin/netbeans
	# dosym /opt/${P}/bin/rmid_wrapper.sh /usr/bin/rmid_wrapper
	# dosym /opt/${P}/bin/unsupported/nbscript.sh /usr/bin/nbscript

	# install icon and desktop entry for gnome
	if [ "`use gnome`" ] ; then
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/netbeans.png
		insinto /usr/share/gnome/apps/Development
		doins ${FILESDIR}/netbeans.desktop
	fi
}
