# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-vim/cream/cream-0.30.ebuild,v 1.4 2004/07/18 23:23:28 aliz Exp $

inherit vim-plugin

DESCRIPTION="Cream is an easy-to-use configuration of the GVim text editor"
HOMEPAGE="http://cream.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
	linguas_en? ( ${HOMEPAGE}/cream-spell-dict-eng-l.zip )
	linguas_fr? ( ${HOMEPAGE}/cream-spell-dict-fre-l.zip )
	linguas_es? ( ${HOMEPAGE}/cream-spell-dict-spa-l.zip )
	linguas_de? ( ${HOMEPAGE}/cream-spell-dict-ger-l.zip )"

IUSE=""
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 sparc ~ppc mips ~amd64"

DEPEND=""
RDEPEND=">=app-editors/gvim-6.2
	dev-util/ctags"

src_unpack() {
	mkdir -p ${S}/spelldicts

	# install spell dictionaries into ${S}/spelldicts
	local my_a
	for my_a in ${A} ; do
		if [ -z ${my_a/*spell-dict*/} ] ; then
			cd ${S}/spelldicts
			unpack ${my_a}
		else
			cd ${WORKDIR}
			unpack ${my_a}
		fi
	done

	# change installation path
	cd ${S}
	sed -i "s:VIMRUNTIME:VIM:" cream || die "sed #1 broke"
	sed -i "/let \$CREAM/s:VIMRUNTIME:VIM:" creamrc || die "sed #2 broke"
}

src_install() {
	# install launcher and menu entry
	dobin cream
	insinto /usr/share/applications
	doins cream.desktop
	insinto /usr/share/icons
	doins cream.svg cream.png

	# install shared vim files
	insinto /usr/share/vim/cream
	doins *.vim creamrc
	local dir
	for dir in addons bitmaps spelldicts ; do
		cp -R ${dir} ${D}/usr/share/vim/cream
	done
	dodir /usr/share/vim/vimfiles
	cp -R help ${D}/usr/share/vim/vimfiles/doc

	# install docs
	dodoc docs/*
	dohtml docs-html/*
}

pkg_postinst() {
	einfo " "
	einfo "To specify which dictionaries are installed with this ebuild,"
	einfo "set the LINGUAS variable in /etc/make.conf. For example, to"
	einfo "install full English and French dictionaries, use:"
	einfo "    LINGUAS=\"en fr\""
	einfo " "
	if [ -z "${LINGUAS}" ] ; then
		einfo "By default, a small English dictionary was installed."
		einfo " "
	fi
}
