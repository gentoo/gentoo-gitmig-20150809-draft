# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-biology/staden-bin/staden-bin-1.7.0.ebuild,v 1.1 2006/10/22 16:37:35 ribosome Exp $

inherit multilib

DESCRIPTION="The Staden Package - Biological sequence handling and analysis"
LICENSE="staden"
HOMEPAGE="http://staden.sourceforge.net"
SRC_URI="mirror://sourceforge/staden/staden-linux-x86-${PV//./-}.tar.gz"

SLOT="0"
IUSE=""
KEYWORDS="~x86"

ITCLTK_PV="3.3"
IWIDGETS_PV="4.0.1"

RDEPEND="app-shells/pdksh
	=media-libs/libpng-1.2*
	=sci-libs/io_lib-1.10*
	~dev-tcltk/itcl-${ITCLTK_PV}
	~dev-tcltk/itk-${ITCLTK_PV}
	~dev-tcltk/iwidgets-${IWIDGETS_PV}
	x11-libs/libX11"

S="${WORKDIR}/staden-linux-x86-${PV//./-}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# Remove Gentoo-provided libraries.
	rm lib/linux-binaries/libpng* || die "Could not remove libpng."
	rm -r lib/itcl${ITCLTK_PV} || die "Could not remove itcl."
	rm -r lib/itk${ITCLTK_PV} || die "Could not remove itk."
	rm lib/iwidgets || die "Could not remove iwidgets."

	# Remove executables provided by the io_lib package.
	for i in append_sff convert_trace extract_seq get_comment hash_extract \
			hash_sff hash_tar index_tar makeSCF scf_dump scf_info scf_update \
			trace_dump ztr_dump; do
		rm linux-bin/${i} || die "Could not remove io_lib program: ${i}."
	done

	# Remove the help program, which is only a wrapper to launch netscape
	# with a non-existent hypertext file.
	rm linux-bin/staden_help || die "Could not remove staden-help."

	# Remove broken prebuilt EMBOSS tcl/tk GUIs.
	rm tables/emboss_menu
	rm -r lib/spin_emboss/acdtcl
	rm -r lib/spin2_emboss/acdtcl

	sed -e 's:/usr/bin/nawk:/usr/bin/awk:' -i linux-bin/fasta-split || \
			die "Could not patch fasta-split."
	sed -e 's:/usr/local/badger/gap4_test:/opt/staden:' \
			-i linux-bin/finish_cDNA -i linux-bin/finish_cDNA_ends_only || \
			die "Could not patch finish_cDNA"
}

src_compile() {
	echo; einfo "Nothing to compile"; echo
}

src_install() {
	# There is no Makefile.
	dodir /opt/staden
	cp -R "${S}"/* "${D}"/opt/staden/ || die "Could not copy package files."
	dosym /opt/staden/doc /usr/share/doc/${PF} || die "Could not symlink docs."

	# Staden programs look for the tcl/tk/itcl/itk/iwidgets libraries in the
	# package root.
	dosym /usr/$(get_libdir)/itcl${ITCLTK_PV} /opt/staden/lib/itcl${ITCLTK_PV} \
			|| die "Could not symlink itcl."
	dosym /usr/$(get_libdir)/itk${ITCLTK_PV} /opt/staden/lib/itk${ITCLTK_PV} \
			|| die "Could not symlink itk."
	dosym /usr/$(get_libdir)/iwidgets${IWIDGETS_PV} /opt/staden/lib/iwidgets \
			|| die "Could not symlink iwidgets."

	dodir /etc/env.d
	cat <<- EOF > "${D}"/etc/env.d/60staden
		STADENROOT="/opt/staden"
	EOF
}

pkg_postinst() {
	echo
	einfo "Before using Staden applications, csh users should source"
	einfo "\"/opt/staden/staden.login\", whilst bash users should source"
	einfo "\"/opt/staden/staden.profile\"."
	echo
}
