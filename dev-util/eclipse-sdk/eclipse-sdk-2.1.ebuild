# Copyright 2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/eclipse-sdk/eclipse-sdk-2.1.ebuild,v 1.1 2003/06/30 18:30:03 karltk Exp $

DESCRIPTION="Eclipse Tools Platform"
HOMEPAGE="http://www.eclipse.org/"
SRC_URI="http://download.eclipse.org/downloads/drops/R-2.1-200303272130/eclipse-sourceBuild-srcIncluded-2.1.zip"
LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS=""
RDEPEND=">=virtual/jdk-1.3
        >=x11-libs/gtk+-2.2.1-r1
        =gnome-base/gnome-vfs-2*"

DEPEND="${RDEPEND}
        >=virtual/jdk-1.3
	>=dev-java/ant-1.4
        ppc? ( app-shells/tcsh )"

src_unpack() {
	mkdir ${S}
	cd ${S}
	unpack ${A}
}

src_compile() {
	./build -os linux -ws gtk -target compile
	./build -os linux -ws gtk -target buildDoc
	./build -os linux -ws gtk -target install
}

src_install() {
	dodir /opt/eclipse

	# 2003-06-30, karltk: It appears there's no easy way to the
	# final install part. If it's just a case if stupiditis on my
	# part, feel free to fix it.

	dodir /opt/eclipse/features
	dodir /opt/eclipse/plugins
	
	for i in ${desired_features} ; do
		cp -a ${S}/features/${i} ${D}/opt/eclipse/features/
	done

	exeinto /opt/eclipse
	doexe eclipse
	
	for i in ${desired_files} ; do 
		cp -a ${S}/${i} ${D}/opt/eclipse
	done
	rm -rf ${D}/opt/eclipse/features/*/build.{xml,properties}

	for i in ${desired_plugins} ; do
		dodir /opt/eclipse/plugins/${i}
		src=${S}/plugins/${i}
		dst=${D}/opt/eclipse/plugins/${i}

		for x in about.html {plugin,fragment}.xml {plugin,fragment}.properties ; do
			if [ -e ${src}/${x} ] ; then
				cp -a ${src}/${x} ${dst}/
			fi
		done

		z="`find ${src} -maxdepth 1 -iname \"*.jar\"`"
		if [ -n "${z}" ] ; then
			cp ${z} ${dst}/
		fi

		z=`cd ${src} ; find -iname "*.so"`
		echo "|${z}|"
		for x in ${z} ; do
			dn=`dirname ${x}`
			mkdir -p ${dst}/${dn}
			cp ${src}/${x} ${dst}/${dn}/
		done
	done

	
	dodoc  plugins/org.eclipse.platform/{cpl-v10.html,notice.html}
}

# this is the really ugly part
desired_files="
splash.bmp
startup.jar
icon.xpm"

desired_features="
org.eclipse.jdt-feature
org.eclipse.pde-feature
org.eclipse.platform-feature
org.eclipse.platform.linux.gtk-feature
org.eclipse.sdk.linux.gtk-feature
org.eclipse.team.extras-feature"

desired_plugins="
org.apache.ant/
org.apache.lucene/
org.apache.xerces/
org.eclipse.ant.core/
org.eclipse.ant.optional.junit/
org.eclipse.compare/
org.eclipse.core.boot/
org.eclipse.core.resources/
org.eclipse.core.resources.linux/
org.eclipse.core.runtime/
org.eclipse.debug.core/
org.eclipse.debug.ui/
org.eclipse.help/
org.eclipse.help.appserver/
org.eclipse.help.ui/
org.eclipse.help.webapp/
org.eclipse.jdt/
org.eclipse.jdt.core/
org.eclipse.jdt.debug/
org.eclipse.jdt.debug.ui/
org.eclipse.jdt.doc.isv/
org.eclipse.jdt.doc.user/
org.eclipse.jdt.junit/
org.eclipse.jdt.launching/
org.eclipse.jdt.ui/
org.eclipse.jface/
org.eclipse.jface.text/
org.eclipse.pde/
org.eclipse.pde.build/
org.eclipse.pde.core/
org.eclipse.pde.doc.user/
org.eclipse.pde.runtime/
org.eclipse.pde.ui/
org.eclipse.platform/
org.eclipse.platform.doc.isv/
org.eclipse.platform.doc.user/
org.eclipse.platform.linux.gtk/
org.eclipse.sdk.linux.gtk/
org.eclipse.search/
org.eclipse.swt/
org.eclipse.swt.gtk/
org.eclipse.team.core/
org.eclipse.team.cvs.core/
org.eclipse.team.cvs.ssh/
org.eclipse.team.cvs.ui/
org.eclipse.team.extras/
org.eclipse.team.ftp/
org.eclipse.team.ui/
org.eclipse.team.webdav/
org.eclipse.text/
org.eclipse.tomcat/
org.eclipse.ui/
org.eclipse.ui.editors/
org.eclipse.ui.externaltools/
org.eclipse.ui.views/
org.eclipse.ui.workbench/
org.eclipse.ui.workbench.texteditor/
org.eclipse.update.core/
org.eclipse.update.core.linux/
org.eclipse.update.ui/
org.eclipse.update.ui.forms/
org.eclipse.webdav/
org.junit/"
