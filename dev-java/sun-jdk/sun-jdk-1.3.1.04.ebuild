# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.3.1.04.ebuild,v 1.3 2002/08/26 16:47:25 karltk Exp $

. /usr/portage/eclass/inherit.eclass
inherit java

At="j2sdk-1_3_1_04-linux-i586.bin"
S=${WORKDIR}/jdk1.3.1_04
SRC_URI=""
DESCRIPTION="Sun Java Development Kit 1.3.1"
HOMEPAGE="http://java.sun.com/j2se/1.3/download-linux.html"
DEPEND="virtual/glibc
	>=dev-java/java-config-0.2.2
	doc? ( =dev-java/java-sdk-docs-1.3.1* )"
RDEPEND="$DEPEND"
PROVIDE="virtual/jre-1.3.1
	virtual/jdk-1.3.1
	virtual/java-scheme-2"
LICENSE="sun-bcla"
SLOT="1.3"
KEYWORDS="x86 -ppc -sparc -sparc64"
	
src_unpack() {
	if [ ! -f ${DISTDIR}/${At} ] ; then
		die "Please download ${At} from ${HOMEPAGE}"
	fi
	tail +291 ${DISTDIR}/${At} > install.sfx
	chmod +x install.sfx
	./install.sfx
	rm install.sfx
}

src_install () {
	local dirs="bin include include-old jre lib"
	dodir /opt/${P}
	
	
	for i in $dirs ; do
		cp -a $i ${D}/opt/${P}/
	done

	dodoc COPYRIGHT README LICENSE
	dohtml README.html

	doman man/man1/*.1

	dodir /opt/${P}/share/
	cp -a demo src.jar ${D}/opt/${P}/share/

        if [ "`use mozilla`" ] ; then                                           
		dodir /usr/lib/mozilla/plugins                                  
		dosym /opt/${P}/jre/plugin/i386/ns600/libjavaplugin_oji.so /usr/lib/mozilla/plugins/
	fi                            

	set_java_env ${FILESDIR}/${VMHANDLE} || die
}

pkg_postinst () {                                                               
	# Set as default VM if none exists
	java_pkg_postinst

	if [ "`use mozilla`" ] ; then                                           
		einfo "The Mozilla browser plugin has been installed as /usr/lib/mozilla/plugins/libjavaplugin_oji.so"
	else                                                                    
		einfo "To install the Java plugin for Mozilla manually, do:"
		einfo "ln -s /opt/${P}/jre/plugin/i386/mozilla/libjavaplugin_oji.so /usr/lib/mozilla/plugins/"
		einfo '(Make certain the directory /usr/lib/mozilla/plugins exists first)'
	fi                                                                      
}                                                                               
                                                                            
