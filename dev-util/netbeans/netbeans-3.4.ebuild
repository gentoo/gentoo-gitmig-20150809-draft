# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/netbeans/netbeans-3.4.ebuild,v 1.7 2003/05/26 10:49:11 absinthe Exp $

MY_BUILD=200208222340
MY_P=NetBeansIDE-release34
S=${WORKDIR}/${PN}
DESCRIPTION="NetBeans ${PV} IDE for Java"
SRC_URI="http://www.netbeans.org/download/release34/night/build${MY_BUILD}/${MY_P}.tar.bz2"
HOMEPAGE="http://www.netbeans.org"

SLOT="0"
LICENSE="GPL-2 Apache-1.1 sun-bcla-j2ee JPython SPL"
KEYWORDS="x86 sparc alpha"
#still need to add JPython, Sun Public and DynamicJava licenses
#sun-j2ee actually contains Sun Binary Code license
#will have to be renamed and containing it ebuilds updated at spome point..

DEPEND=">=virtual/jdk-1.3"

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
	rm -f ${S}/bin/runide_exe_defaults
	rm -f ${S}/bin/runide*.com
	rm -f ${S}/bin/runideos2.cmd
	rm -f ${S}/bin/fastjavac/fastjavac.exe
	rm -f ${S}/bin/fastjavac/fastjavac.sun
	rm -f ${S}/bin/fastjavac/fastjavac.sun.intel
	rm -f ${S}/bin/unsupported/*.bat

	# Remove MacOS X Binaries?  This doesn't necessarily make
	# sense because MacOS X could live happily beside Gentoo.
	rm -f ${S}/bin/macosx_launcher.dmg

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

	# If either Gnome or KDE are installed, then install the icons.
	if [ "`use gnome || use kde`" ] ; then
		echo "Adding icons...."
		insinto /usr/share/pixmaps
		doins ${FILESDIR}/netbeans.png
	fi		

	# If Gnome is installed, then copy in the desktop entry.
	if [ "`use gnome`" ] ; then
		einfo "Adding Gnome support...."
		insinto /usr/share/gnome/apps/Development
		doins ${FILESDIR}/netbeans.desktop
		echo "Exec=/opt/${P}/bin/runide.sh" >> ${D}/usr/share/gnome/apps/Development/netbeans.desktop
		echo >> ${D}/usr/share/gnome/apps/Development/netbeans.desktop
	fi

	# If KDE is installed, the copy in the menu entry to the
	# "Development" menu.
	# Unfortunately, the file doesn't contain any internationalized
	# text at the moment.
	if [ "`use kde`" ] ; then
		einfo "Adding KDE support...."
		DESKTOP_FILE=netbeans-KDE.desktop
		DESKTOP_DIR=${KDEDIR}/share/applnk/Development
		DESKTOP=${DESKTOP_DIR}/${DESKTOP_FILE}
		insinto ${DESKTOP_DIR}
		doins ${FILESDIR}/${DESKTOP_FILE}
		echo "Name=NetBeans ${PV}" >> ${D}/${DESKTOP}
		echo "Exec=/opt/${P}/bin/runide.sh" >> ${D}/${DESKTOP}
		echo "Icon=/usr/share/pixmaps/netbeans.png" >> ${D}/${DESKTOP}
		echo >> ${D}/${DESKTOP}
	fi
}
