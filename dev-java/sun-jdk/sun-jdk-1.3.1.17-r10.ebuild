# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-java/sun-jdk/sun-jdk-1.3.1.17-r10.ebuild,v 1.4 2006/09/01 01:02:13 nichoj Exp $

JAVA_SUPPORTS_GENERATION_1="true"
inherit java-vm-2 eutils

MY_PV=${PV%.*}_${PV##*.}
MY_P=jdk${MY_PV}
MY_PVB=${PV%.*}

At="j2sdk-${PV//./_}-linux-i586.bin"
S="${WORKDIR}/${MY_P}"
SRC_URI="${At}"
DESCRIPTION="Sun Java Development Kit"
HOMEPAGE="http://java.sun.com/j2se/1.3/"
DEPEND="
	doc? ( =dev-java/java-sdk-docs-1.3.1* )"
RDEPEND="sys-libs/lib-compat
	doc? ( =dev-java/java-sdk-docs-1.3.1* )
	nsplugin? ( dev-libs/glib x11-libs/gtk+ )
	X? ( || (	(
					x11-libs/libX11
					x11-libs/libXext
					x11-libs/libXp
					x11-libs/libXt
					x11-libs/libXtst
				)
				virtual/x11
			)
		)"

LICENSE="sun-bcla-java-vm"
SLOT="1.3"
KEYWORDS="-* ~x86"
RESTRICT="fetch stricter"

IUSE="X doc nsplugin"
# this is needed for proper operating under a PaX kernel without activated grsecurity acl
CHPAX_CONSERVATIVE_FLAGS="pemsv"

DOWNLOAD_URL="http://javashoplm.sun.com/ECom/docs/Welcome.jsp?StoreId=22&PartDetailId=j2sdk-${MY_PV}-oth-JPR&SiteId=JSC&TransactionId=noreg"

pkg_nofetch() {
	einfo "Please download ${At} from:"
	einfo ${DOWNLOAD_URL}
	einfo "(SDK 32-bit/64-bit for Windows/Linux/Solaris SPARC 32-bit for Solaris x86, then select download Linux Self-extracting."
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	if [ ! -r ${DISTDIR}/${At} ]; then
		eerror "cannot read ${At}. Please check the permission and try again."
		die
	fi
	#Search for the ELF Header
	testExp=`echo -e "\177\105\114\106\001\001\001"`
	startAt=`grep -aonm 1 ${testExp}  ${DISTDIR}/${At} | cut -d: -f1`
	tail -n +${startAt} ${DISTDIR}/${At} > install.sfx
	chmod +x install.sfx
	./install.sfx
	rm install.sfx

	sed "s/head -1/head -n 1/" -i ${MY_P}/bin/.java_wrapper
}

src_install() {
	local dirs="bin include include-old jre lib man"
	dodir /opt/${P}

	for i in ${dirs} ; do
		if [ "${i}" == "bin" ] ; then
			dodir /opt/${P}/${i}
			cp -dPR ${i}/.java_wrapper ${D}/opt/${P}/bin/
			cp -dPR ${i}/* ${D}/opt/${P}/bin/
		elif [ "${i}" == "jre" ] ; then
			dodir /opt/${P}/${i}
			dodir /opt/${P}/${i}/bin
			cp -dPR ${i}/bin/.java_wrapper ${D}/opt/${P}/${i}/bin/
			cp -dPR ${i}/bin/* ${D}/opt/${P}/${i}/bin/
			cp -dPR	${i}/CHANGES \
				${i}/COPYRIGHT \
				${i}/ControlPanel.html \
				${i}/LICENSE \
				${i}/README \
				${i}/Welcome.html \
				${i}/lib \
				${i}/plugin \
				${D}/opt/${P}/${i}/
		else
			cp -dPR ${i} ${D}/opt/${P}/
		fi
	done

	dodoc COPYRIGHT README LICENSE
	dohtml README.html

	dodir /opt/${P}/share/
	cp -a demo src.jar ${D}/opt/${P}/share/

	local javaplugin="/opt/${P}/jre/plugin/i386/ns600/libjavaplugin_oji.so"

	if use nsplugin; then
		install_mozilla_plugin ${javaplugin}
	else
		rm "${D}/${javaplugin}" || die "Removing javaplugin failed."
	fi

	set_java_env
}

pkg_postinst () {
	# Set as default VM if none exists
	java_pkg_postinst

	if use nsplugin; then
		echo
		ewarn "The javaplugin in this version does not work with"
		ewarn "Firefox 1.5."
	fi

	# if chpax is on the target system, set the appropriate PaX flags
	# this will not hurt the binary, it modifies only unused ELF bits
	# but may confuse things like AV scanners and automatic tripwire
	if has_version sys-apps/chpax
	then
		echo
		einfo "setting up conservative PaX flags for jar, javac and java"

		for paxkills in "jar" "javac" "java" "javah" "javadoc"
		do
			chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${P}/bin/$paxkills
		done

		# /opt/sun-jdk-1.3.1.09/jre/bin/java_vm
		chpax -${CHPAX_CONSERVATIVE_FLAGS} /opt/${P}/jre/bin/java_vm

		einfo "you should have seen lots of chpax output above now"
		ewarn "make sure the grsec ACL contains those entries also"
		ewarn "because enabling it will override the chpax setting"
		ewarn "on the physical files - help for PaX and grsecurity"
		ewarn "can be given by #gentoo-hardened + hardened@gentoo.org"
	fi

	if ! use X; then
		echo
		ewarn "Some parts of Sun's JDK require X11 to be installed."
		ewarn "Be careful which Java libraries you attempt to use."
	fi
}
