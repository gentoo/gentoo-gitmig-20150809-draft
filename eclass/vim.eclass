# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/vim.eclass,v 1.15 2003/03/16 04:21:05 seemant Exp $
#
# Author Ryan Phillips <rphillips@gentoo.org>
# Modified by: Seemant Kulleen <seemant@gentoo.org>
# Ripped from the vim ebuilds. src_compile and install
# should be integrated in at some point

ECLASS=vim
EXPORT_FUNCTIONS src_unpack

inherit eutils

# Calculate the version based on the name of the ebuild
vim_version="${PV%_pre*}"
vim_pre="${PV##*_pre}"

if [ "${vim_version}" = "${vim_pre}" ]; then
	# Final releases prior to 6.0 include a dash and decimal point in
	# the directory name
	if [ "${vim_version%%.*}" -lt 6 ]; then
		S="$WORKDIR/vim-${vim_version}"
	else
		S="$WORKDIR/vim${vim_version//.}"
	fi
	vim_letters=
	MY_P="vim-${vim_version}"
	SRC_URI="ftp://ftp.vim.org/pub/vim/unix/${MY_P}.tar.bz2
		ftp://ftp.us.vim.org/pub/vim/unix/${MY_P}.tar.bz2"
#		ftp://ftp.vim.org/pub/vim/extra/${MY_P}-extra.tar.gz"
elif [ "${vim_pre}" -lt 27 ]; then
	# Handle (prerelease) versions with one trailing letter
	vim_letters=`echo ${vim_pre} | awk '{printf "%c", $0+96}'`
	S="$WORKDIR/vim${vim_version//.}${vim_letters}"
	MY_P="vim-${vim_version}${vim_letters}"
	SRC_URI="ftp://ftp.vim.org/pub/vim/unreleased/unix/${MY_P}.tar.bz2
		ftp://ftp.us.vim.org/pub/vim/unreleased/unix/${MY_P}.tar.bz2"
#		ftp://ftp.vim.org/pub/vim/extra/${MY_P}-extra.tar.gz"

elif [ "${vim_pre}" -lt 703 ]; then
	# Handle (prerelease) versions with two trailing letters
	vim_letters=`echo ${vim_pre} | awk '{printf "%c%c", $0/26+96, $0%26+96}'`
	S="$WORKDIR/vim${vim_version//.}${vim_letters}"
	MY_P="vim-${vim_version}${vim_letters}"
	SRC_URI="ftp://ftp.vim.org/pub/vim/unreleased/unix/${MY_P}.tar.bz2
		ftp://ftp.us.vim.org/pub/vim/unreleased/unix/${MY_P}.tar.bz2"
#		ftp://ftp.vim.org/pub/vim/extra/${MY_P}-extra.tar.gz"
else
	die "Eek!  I don't know how to interpret the version!"
fi

[ ! -z "${VIMPATCH}" ] && \
	SRC_URI="${SRC_URI}
		mirror://gentoo/vim-${PV}-patches-001-${VIMPATCH}.tar.bz2"

SRC_URI="${SRC_URI}
	mirror://vim-${PV}-gentoo-patches.tar.bz2"

LANG="vim-${vim_version}-lang.tar.gz"
if [ ! -z "${LANG}" ]; then
	SRC_URI="${SRC_URI} nls? ( ftp://ftp.vim.org/pub/vim/extra/${LANG} )"
fi

HOMEPAGE="http://www.vim.org/"
SLOT="0"
LICENSE="vim"

epatch_prep() {
	
	ebegin "Removing superfluous patches..."
	awk '/\(extra\).* Win32:|\(extra\) MS-DOS:|VMS:|\(extra\) BC5:|\(extra\) Mac:/ {print $2}' ${WORKDIR}/README | \
		xargs -i rm -f ${WORKDIR}/vimpatches/{}.gz

	for i in ${EXCLUDE_PATCH}
	do
		rm -f ${WORKDIR}/vimpatches/${PV}.${i}.gz
	done

	eend $?
}


vim_src_unpack() {
	unpack ${A}
	# Fixup a script to use awk instead of nawk
	cd ${S}/runtime/tools
	mv mve.awk mve.awk.old
	( read l; echo "#!/usr/bin/awk -f"; cat ) <mve.awk.old >mve.awk

	# Apply any patches available for this version
	cd ${S}
	epatch_prep

	EPATCH_SUFFIX="gz" EPATCH_FORCE="yes" \
		epatch ${WORKDIR}/vimpatches/

	# Another set of patch's borrowed from src rpm to fix syntax error's etc.
	cd ${S}
	EPATCH_SUFFIX="gz" \
		EPATCH_FORCE="yes" \
		epatch ${WORKDIR}/gentoo/patches-all/
	
	# Apply patches to the specific package (gvim, vim, vim-core)
#	if [ "${PN}" = "gvim" ]
#	then
#		cd ${S}
#		EPATCH_SUFFIX=-"gz" \
#			EPATCH_FORCE="yes" \
#			epatch ${WORKDIR}/gentoo/patches-gvim/
#	fi
#
#	if [ "${PN}" = "vim-core" ]
#	then
#		cd ${S}
#		EPATCH_SUFFIX="gz" \
#			EPATCH_FORCE="yes" \
#			epatch ${WORKDIR}/gentoo/patches-vim-core/
#	fi
#
#	if [ "${PN}" = "vim" ]
#	then
#		cd ${S}
#		EPATCH_SUFFIX="gz" \
#			EPATCH_FORCE="yes" \
#			epatch ${WORKDIR}/gentoo/patches-vim/
#	fi
}

src_compile() {
	local myconf

	if [ "${PN}" = "vim-core" ]
	then
		myconf="--with-features=tiny \
			--enable-gui=no \
			--without-x \
			--disable-perlinterp \
			--disable-pythoninterp \
			--disable-rubyinterp \
			--disable-gpm"

		use nls \
			&& myconf="${myconf} --enable-multibyte" \
			|| myconf="${myconf} --disable-nls"
	else
		myconf="--with-features=huge \
			--enable-multibyte \
			--enable-cscope"
		use nls	|| myconf="${myconf} --disable-nls"
		use perl   && myconf="${myconf} --enable-perlinterp"
		use python && myconf="${myconf} --enable-pythoninterp"
		use ruby   && myconf="${myconf} --enable-rubyinterp"

		# tclinterp is BROKEN.  See note above DEPEND=
		#   use tcltk  && myconf="$myconf --enable-tclinterp"

		# Added back gpm for temporary will remove if necessary, I think that I
		# have
		# fixed most of gpm so it should be fine.
		use gpm	|| myconf="${myconf} --disable-gpm"

		# the console vim will change the caption of a terminal in X.
		# the configure script should autodetect X being installed, so
		# we'll specifically turn it off if X is not in the USE vars.
		# -rphillips
		if [ "${PN}" = "vim" ]
		then
			use X \
				&& myconf="${myconf} --with-x" \
				 || myconf="${myconf} --without-x"
		fi
	fi

	# This should fix a sandbox violation.
	for file in /dev/pty/s*
	do
		addwrite $file
	done


	if [ "${PN}" = "gvim" ]
	then
		myconf="${myconf} --with-vim-name=gvim --with-x"
		if use gtk2; then
			myconf="${myconf} --enable-gui=gtk2 --enable-gtk2-check"
		elif use gnome; then
			myconf="${myconf} --enable-gui=gnome"
		elif use gtk; then
			myconf="${myconf} --enable-gui=gtk"
		else
			myconf="${myconf} --enable-gui=athena"
		fi
	else
		myconf="${myconf} --enable-gui=no"
	fi

	econf ${myconf} || die "vim configure failed"

	
	if [ "${PN}" = "vim-core" ]
	then
		make tools || die "vim make failed"
		cd ${S}
		rm src/vim
	else
		# move config files to /etc/vim/
		echo "#define SYS_VIMRC_FILE \"/etc/vim/vimrc\"" \
			>>${WORKDIR}/vim61/src/feature.h
		echo "#define SYS_GVIMRC_FILE \"/etc/vim/gvimrc\"" \
			>>${WORKDIR}/vim61/src/feature.h

		# Parallel make does not work
		make || die "vim make failed"
	fi
}

src_install() {

	if [ "${PN}" = "vim-core" ]
	then
		dodir /usr/{bin,share/{man/man1,vim}}
		cd src
		make \
			installruntime \
			installhelplinks \
			installmacros \
			installtutor \
			installtools \
			install-languages \
			install-icons \
			DESTDIR=${D} \
			BINDIR=/usr/bin \
			MANDIR=/usr/share/man \
			DATADIR=/usr/share \
			|| die "install failed"

			dodoc README*
			cd $D/usr/share/doc/$PF
			ln -s ../../vim/*/doc $P

			keepdir /usr/share/vim/vim${vim_version/.}/keymap

			# fix problems with vim not finding its data files.
			echo "VIMRUNTIME=/usr/share/vim/vim${vim_version/.}" > 40vim
			insinto /etc/env.d
			doins 40vim
	elif [ "${PN}" = "gvim" ]
	then
		dobin src/gvim
		dosym gvim /usr/bin/gvimdiff
		insinto /etc/vim
		doins ${FILESDIR}/gvimrc
	else
		dobin src/vim
		ln -s vim ${D}/usr/bin/vimdiff
		ln -s vim ${D}/usr/bin/rvim
		ln -s vim  ${D}/usr/bin/ex
		ln -s vim  ${D}/usr/bin/view
		ln -s vim  ${D}/usr/bin/rview

		# Default vimrc
		insinto /etc/vim/
		doins ${FILESDIR}/vimrc
	fi

}

pkg_postinst() {
	einfo
	if [ "${PN}" = "gvim" ]
	then
		einfo "To enable UTF-8 viewing, set guifont and guifontwide: "
		einfo ":set guifont=-misc-fixed-medium-r-normal-*-18-120-100-100-c-90-iso10646-1"
		einfo ":set guifontwide=-misc-fixed-medium-r-normal-*-18-120-100-100-c-180-iso10646-1"
		einfo
		einfo "note: to find out which fonts you can use, please read the UTF-8 help:"
		einfo ":h utf-8"
		einfo
		einfo "Then, set read encoding to UTF-8:"
		einfo ":set encoding=utf-8"
	else
		einfo "gvim has now a seperate ebuild, 'emerge gvim' will install gvim"
	fi
	einfo
}
