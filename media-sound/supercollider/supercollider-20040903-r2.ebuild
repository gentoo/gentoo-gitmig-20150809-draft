# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/supercollider/supercollider-20040903-r2.ebuild,v 1.1 2007/08/03 17:05:52 drac Exp $

inherit elisp-common eutils flag-o-matic

DESCRIPTION="A real time audio synthesis programming language"
HOMEPAGE="http://www.audiosynth.com"
SRC_URI="mirror://gentoo/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86"
IUSE="emacs"

RDEPEND="media-sound/jack-audio-connection-kit
	 media-libs/alsa-lib
	 media-libs/libsndfile"
DEPEND="${RDEPEND}
	sys-apps/sed
	emacs? ( virtual/emacs )"

S="${WORKDIR}"/SuperCollider3
SITEFILE=50${PN}-gentoo.el

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-gcc4.patch

	# Change default config file location from /etc to /etc/supercollider
	sed -i -e "s:/etc/sclang.cfg:/etc/supercollider/sclang.cfg:" source/lang/LangSource/SC_LanguageClient.cpp
	sed -i -e "s:/etc/sclang.cfg:/etc/supercollider/sclang.cfg:" linux/examples/sclang.cfg.in

	# Change the ridiculous default scsynth location on sample ~/.scsynth.sc file
	sed -i -e "s:/usr/local/music/bin/scsynth:/usr/bin/scsynth:" linux/examples/sclang.sc

	# Uncommenting a line per linux/examples/sclang.cfg.in
	if ! use emacs; then
		sed -i -e \
			"s:#-@SC_LIB_DIR@/Common/GUI/Document.sc:-@SC_LIB_DIR@/Common/GUI/Document.sc:"	\
			linux/examples/sclang.cfg.in
	fi

	filter-ldflags -Wl,--as-needed --as-needed
}

src_compile() {
	local myconf
	if use emacs; then
		myconf="${myconf} --enable-scel --with-lispdir="${SITELISP}/${PN}""
	else
		myconf="${myconf} --disable-scel"
	fi

	# Do the main compilation
	./linux/bootstrap
	econf ${myconf} || die
	emake || die "emake failed."
	cd "${S}"/linux/examples
	emake sclang.cfg

	# Also compile Emacs extensions if need be
	if use emacs; then
		cd "${S}"/linux/scel
		emake || die "emake on skel failed."
	fi
}

src_install() {
	# Main install
	einstall || die "einstall failed."

	# Install our config file
	insinto /etc/supercollider
	doins linux/examples/sclang.cfg

	# Documentation
	mv linux/README linux/README-linux
	mv linux/scel/README linux/scel/README-scel
	dodoc linux/README-linux linux/scel/README-scel

	# Our documentation
	sed -e "s:@DOCBASE@:/usr/share/doc/${PF}:" \
		< "${FILESDIR}"/README-gentoo.txt | gzip \
		> "${D}"/usr/share/doc/${PF}/README-gentoo.txt.gz

	# RTFs (don't gzip)
	insinto /usr/share/doc/${PF}
	doins doc/*.rtf changes.rtf

	# Example files (don't gzip)
	insinto /usr/share/doc/${PF}/examples
	doins linux/examples/onetwoonetwo.sc linux/examples/sclang.sc

	# Help files included with project (again, don't gzip)
	cp -R "${S}"/build/Help "${D}"/usr/share/doc/${PF}

	# Emacs installation
	if use emacs; then
		cd "${S}"/linux/scel
		einstall lispdir="${D}/${SITELISP}/${PN}" || die "einstall on scel failed"
		elisp-site-file-install "${FILESDIR}/${SITEFILE}"
	fi

}

pkg_postinst() {
	elog
	elog "Notice: SuperCollider is not very intuitive to get up and running."
	elog "The best course of action to make sure that the installation was"
	elog "successful and get you started with using SuperCollider is to take"
	elog "a look through /usr/share/doc/${PF}/README-gentoo.txt.gz"
	elog
	use emacs && elisp-site-regen
}
pkg_postrm() {
	use emacs && elisp-site-regen
}
