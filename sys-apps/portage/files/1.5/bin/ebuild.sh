#!/bin/bash
source /etc/profile
export PATH="/usr/lib/portage/bin:${PATH}"
source /etc/rc.d/config/functions
#if no perms are specified, dirs/files will have decent defaults
#(not secretive, but not stupid)
umask 022
export DESTTREE=/usr
export INSDESTTREE=""
export EXEDESTTREE=""
export DOCDESTTREE=""
export INSOPTIONS="-m0644"
export EXEOPTIONS="-m0755"	
export LIBOPTIONS="-m0644"
export DIROPTIONS="-m0755"
export MOPREFIX=${PN}
export KVERS=`uname -r`

src_unpack() { 
	unpack ${A} 
}

src_compile() { 
	return 
}

src_install() 
{ 
	return 
}

pkg_preinst()
{
	return
}

pkg_postinst()
{
	return
}

pkg_prerm()
{
	return
}

pkg_postrm()
{
	return
}

try() {
	eval $*
	if [ $? -ne 0 ]
	then
		echo 
		echo '!!! '"ERROR: the $1 command did not complete successfully."
		echo '!!! '"(\"$*\")"
		echo '!!! '"Since this is a critical task, ebuild will be stopped."
		echo
		exit 1
	fi
}

dyn_touch() {
	local x
	for x in ${A} 
	do
		if [ -e ${DISTDIR}/${x} ]
		then	
			touch ${DISTDIR}/${x}
		fi
	done
}

dyn_digest() {
	local x
	if [ ! -d ${FILESDIR} ]
	then
		install -d ${FILESDIR}
		if [ -n "${MAINTAINER}" ]
		then
			echo ">>> adding ${FILESDIR} to CVS (just in case it isn't there)"
			( echo; cd `/usr/bin/dirname ${FILESDIR}`; cvs add `/usr/bin/basename ${FILESDIR}`; echo)
		fi
	fi
	for x in ${A}
	do
		if [ ! -e ${DISTDIR}/${x} ]
		then
			echo '!!! Cannot compute message digests: '${x} not found
			echo "error, aborting."
			exit 1
		else
	    	mymd5=`md5sum ${DISTDIR}/${x} | cut -f1 -d" "`
	    	echo "MD5 $mymd5 $x" >> ${FILESDIR}/.digest-${PF}
		fi
    done
    mv ${FILESDIR}/.digest-${PF} ${FILESDIR}/digest-${PF}
    if [ -n "${MAINTAINER}" ]
    then
		echo ">>> adding digest-${PF} to CVS (just in case it isn't there)"
		( echo; cd ${FILESDIR}; cvs add digest-${PF}; echo )
    fi
    echo ">>> Computed message digests."
}

digest_check() {
	if [ ! -e ${FILESDIR}/digest-${PF} ]
	then
		echo '!!!'" No message digest file found."
		if [ -n "$MAINTAINER" ]
		then
			echo '>>> Maintainer mode: auto-computing digests.'
			dyn_digest
			return 0
		else
			echo '!!!'" Maintainer: ebuild digest to update message digests."
			return 1
		fi
    fi
	if [ ! -e ${DISTDIR}/${1} ]
	then
		echo '!!!'" ${1} not found."
		echo '!!!'" Ebuild fetch to retrieve files."
		return 1
	fi	
	local mycdigest=`grep " ${1}" ${FILESDIR}/digest-${PF} | cut -f2 -d" "`
	if [ -z "$mycdigest" ]
	then
		echo
		echo '!!!'" No message digest found for ${1}."
		if [ -n "$MAINTAINER" ]
		then
			echo '>>> Maintainer mode: auto-computing digests.'
			dyn_digest
			echo 
			return 0
		else
			echo '!!!'" Maintainer: ebuild digest to update message digests."
			echo
			return 1
		fi
	fi
	local mydigest=`md5sum ${DISTDIR}/${1} | cut -f1 -d" "`
	if [ "$mycdigest" != "$mydigest" ]
	then
		echo
		echo '!!!'" ${1}: message digests do not match!"
		echo '!!!'" ${1} is corrupt or incomplete"
		echo ">>> md5 con ${mycdigest}"
		echo ">>> md5 now ${mydigest}"
		echo ">>> Please delete/redownload ${DISTDIR}/${1}"
		echo
		return 1
	else
		echo ">>> md5 ;-) ${1}"
	fi
	return 0
}

dyn_batchdigest() {
    local x
    if [ ! -e ${FILESDIR}/digest-${PF} ]
    then
	if [ "${A}" != "" ]
	then
		echo "${CATEGORY}/${PF} has no digest file."
	fi
	exit 1
    fi
    	for x in ${A}
    	do
		if [ ! -e ${DISTDIR}/${x} ]
    		then
			echo "${CATEGORY}/${PF}:${x} does not exist in ${DISTDIR}."
			continue
		else
			local mycdigest=`grep " ${x}" ${FILESDIR}/digest-${PF} | cut -f2 -d" "`
			if [ -z "$mycdigest" ]
			then
				echo "${CATEGORY}/${PF}:${x} digest not yet recorded."
				continue
			fi
    			local mydigest=`md5sum ${DISTDIR}/${x} | cut -f1 -d" "`
    			if [ "$mycdigest" != "$mydigest" ]
   			then
				echo "${CATEGORY}/${PF}:${x} is corrupt or has an invalid digest."
			fi
		fi
	done
}


dyn_fetch() {
	local y
	for y in ${A}
	do
		if [ ! -e ${DISTDIR}/${y} ]
		then
			echo ">>> Fetching ${y}..."
			echo
			local x
			local _SRC_URI
		        for x in ${GENTOO_MIRRORS}
			do
			  _SRC_URI="${_SRC_URI} ${x}/distributions/gentoo/gentoo-sources/${y}"
			done
			_SRC_URI="${_SRC_URI} `queryhost.sh "${SRC_URI}"`"
			for x in ${_SRC_URI}
			do
				if [ ! -e ${DISTDIR}/${y} ] 
				then
			    		if [ "$y" = "${x##*/}" ]
			    		then
							echo ">>> Trying site ${x}..."
							eval "${FETCHCOMMAND}"
		    			fi
				fi
			done
			if [ ! -e ${DISTDIR}/${y} ]
			then
  				echo '!!!'" Couldn't download ${y}.  Aborting."
				exit 1
			fi
			echo
    	fi	
	done
	for y in ${A}
	do
		digest_check ${y}
		if [ $? -ne 0 ]
		then
				exit 1
		fi
	done
}

dyn_unpack() {
	trap "abort_unpack" SIGINT SIGQUIT
	local newstuff="no"
	if [ -e ${WORKDIR} ]
	then
		local x
		local checkme
		if [ -n "${MAINTAINER}" ]
		then
			checkme="${DISTDIR}/${A}"
		else
			checkme="${DISTDIR}/${A} ${EBUILD}"
		fi
		for x in $checkme
		do
			echo ">>> Checking ${x}'s mtime..."
			if [ ${x} -nt ${WORKDIR} ]
			then
				echo ">>> ${x} has been updated; recreating WORKDIR..."
				newstuff="yes"
				rm -rf ${WORKDIR}
				break
			fi
		done
	fi
	if [ -e ${WORKDIR} ]
	then
		if [ "$newstuff" = "no" ]
		then
			echo ">>> WORKDIR is up-to-date, keeping..."
			return 0
		fi
	fi
	install -m0700 -d ${WORKDIR}
	cd ${WORKDIR}
	echo ">>> Unpacking source..."
	src_unpack
	echo ">>> Source unpacked."
	cd ..
    trap SIGINT SIGQUIT
}

dyn_clean() {
	if [ -d ${WORKDIR} ]
	then
		rm -rf ${WORKDIR} 
	fi
	if [ -d ${BUILDDIR}/image ]
	then
		rm -rf ${BUILDDIR}/image
	fi
	if [ -d ${BUILDDIR}/build-info ]
	then
		rm -rf ${BUILDDIR}/build-info
	fi
	rm -rf ${BUILDDIR}/.compiled
}

into() {
	if [ $1 = "/" ]
	then
		export DESTTREE=""
	else
		export DESTTREE=$1
		if [ ! -d ${D}${DESTTREE} ]
		then
			install -d ${D}${DESTTREE}
		fi
	fi
}

insinto() {
    if [ $1 = "/" ]
    then
	export INSDESTTREE=""
    else
	export INSDESTTREE=$1
	if [ ! -d ${D}${INSDESTTREE} ]
	then
	    install -d ${D}${INSDESTTREE}
	fi
    fi
}

exeinto() {
    if [ $1 = "/" ]
    then
	export EXEDESTTREE=""
    else
	export EXEDESTTREE=$1
	if [ ! -d ${D}${EXEDESTTREE} ]
	then
	    install -d ${D}${EXEDESTTREE}
	fi
    fi
}
docinto() {
    if [ $1 = "/" ]
    then
	export DOCDESTTREE=""
    else
	export DOCDESTTREE=$1
	if [ ! -d ${D}usr/share/doc/${PF}/${DOCDESTTREE} ]
	then
	    install -d ${D}usr/share/doc/${PF}/${DOCDESTTREE} 
	fi
    fi
}

insopts() {
    INSOPTIONS=""
    for x in $*
    do
	#if we have a debug build, let's not strip anything
	if [ -n "$DEBUG" ] &&  [ "$x" = "-s" ]
	then
	    continue
        else
             INSOPTIONS="$INSOPTIONS $x"
        fi
    done
    export INSOPTIONS
}

diropts() {
	DIROPTIONS=""
	for x in $*
	do
		DIROPTIONS="${DIROPTIONS} $x"
	done
	export DIROPTIONS
}

exeopts() {
    EXEOPTIONS=""
    for x in $*
    do
	#if we have a debug build, let's not strip anything
	if [ -n "$DEBUG" ] &&  [ "$x" = "-s" ]
	then
	    continue
        else
             EXEOPTIONS="$EXEOPTIONS $x"
        fi
    done
    export EXEOPTIONS
}

libopts() {
    LIBOPTIONS=""
    for x in $*
    do
	#if we have a debug build, let's not strip anything
	if [ -n "$DEBUG" ] &&  [ "$x" = "-s" ]
	then
	    continue
        else
             LIBOPTIONS="$LIBOPTIONS $x"
        fi
    done
    export LIBOPTIONS
}

abort_compile() {
    echo 
    echo '*** Compilation Aborted ***'
    echo
    cd ${BUILDDIR} #original dir
    rm -f .compiled
    trap SIGINT SIGQUIT
    exit 1
}

abort_unpack() {
    echo 
    echo '*** Unpack Aborted ***'
    echo
    cd ${BUILDDIR} #original dir
    rm -f .unpacked
    rm -rf work
    trap SIGINT SIGQUIT
    exit 1
}

abort_package() {
    echo 
    echo '*** Packaging Aborted ***'
    echo
    cd ${BUILDDIR} #original dir
    rm -f .packaged
    rm -f ${PKGDIR}/All/${PF}.t*
    trap SIGINT SIGQUIT
    exit 1
}

abort_image() {
    echo 
    echo '*** Imaging Aborted ***'
    echo
    cd ${BUILDDIR} #original dir
    rm -rf image
    trap SIGINT SIGQUIT
    exit 1
}

dyn_compile() {
    trap "abort_compile" SIGINT SIGQUIT
    export CFLAGS CXXFLAGS LIBCFLAGS LIBCXXFLAGS
    if [ ${BUILDDIR}/.compiled -nt ${WORKDIR} ]
    then
	echo ">>> It appears that ${PN} is already compiled.  skipping."
	echo ">>> (clean to force compilation)"
	trap SIGINT SIGQUIT
	return
    fi
    if [ -d ${S} ]
    then
    cd ${S}
    fi
    src_compile 
	cd ${BUILDDIR}
    touch .compiled
	if [ ! -e "build-info" ]
	then
		mkdir build-info
	fi
	cd build-info
	echo "$CFLAGS" > CFLAGS
	echo "$CXXFLAGS" > CXXFLAGS
	echo "$CHOST" > CHOST
	echo "$USE" > USE
	echo "$LICENSE" > LICENSE
	echo "$CATEGORY" > CATEGORY
	echo "$PF" > PF
	echo "$RDEPEND" > RDEPEND
	echo "$PROVIDE" > PROVIDE
	cp ${EBUILD} ${PF}.ebuild
	if [ -n "$DEBUG" ]
	then
		touch DEBUG
	fi
	trap SIGINT SIGQUIT
}

dyn_package() {
    trap "abort_package" SIGINT SIGQUIT
    cd ${BUILDDIR}/image
	tar cvf ../bin.tar *
	cd ..
	bzip2 -f bin.tar
	xpak build-info inf.xpak
	tbz2tool join bin.tar.bz2 inf.xpak ${PF}.tbz2
	mv ${PF}.tbz2 ${PKGDIR}/All
	rm -f inf.xpak bin.tar.bz2
    if [ ! -d ${PKGDIR}/${CATEGORY} ]
	then
		install -d ${PKGDIR}/${CATEGORY}
	fi
	ln -sf ${PKGDIR}/All/${PF}.tbz2 ${PKGDIR}/${CATEGORY}/${PF}.tbz2
    echo ">>> Done."
    cd ${BUILDDIR}
    touch .packaged
    trap SIGINT SIGQUIT
}

dyn_install() {
    local ROOT
    trap "abort_image" SIGINT SIGQUIT
    rm -rf ${BUILDDIR}/image
    mkdir ${BUILDDIR}/image
    if [ -d ${S} ]
    then
    cd ${S}
    fi
    echo
    echo ">>> Install ${PF} into ${D} category ${CATEGORY}"
    src_install
    prepall
	cd ${D}
	echo ">>> Completed installing into ${D}"
    echo
    cd ${BUILDDIR}
    trap SIGINT SIGQUIT
}

dyn_spec() {
    tar czf /usr/src/redhat/SOURCES/${PF}.tar.gz ${O}/${PF}.ebuild ${O}/files

    cat <<__END1__ > ${PF}.spec
Summary: ${DESCRIPTION}
Name: ${PN}
Version: ${PV}
Release: ${PR}
Copyright: GPL
Group: portage/${CATEGORY}
Source: ${PF}.tar.gz
Buildroot: ${D}
%description
${DESCRIPTION}

${HOMEPAGE}

%prep
%setup -c

%build

%install

%clean

%files
/
__END1__

}

dyn_rpm () {
    dyn_spec
    rpm -bb ${PF}.spec
    install -D /usr/src/redhat/RPMS/i386/${PN}-${PV}-${PR}.i386.rpm ${RPMDIR}/${CATEGORY}/${PN}-${PV}-${PR}.rpm
}

dyn_help() {
	echo
	echo "Portage"
	echo "Copyright 2000 Gentoo Technologies, Inc."
	echo 
	echo "How to use the ebuild command:"
	echo 
	echo "The first argument to ebuild should be an existing .ebuild file."
	echo
	echo "One or more of the following options can then be specified.  If more"
	echo "than one option is specified, each will be executed in order."
	echo
	echo "  check       : test if all dependencies get resolved"
	echo "  fetch       : download source archive(s) and patches"
	echo "  unpack      : unpack/patch sources (auto-fetch if needed)"
	echo "  compile     : compile sources (auto-fetch/unpack if needed)"
	echo "  merge       : merge image into live filesystem, recording files in db"
	echo "                (auto-fetch/unpack/compile if needed)"
	echo "  unmerge     : remove package from live filesystem"
	echo "  package     : create tarball package of type ${PACKAGE}"
        echo "                (will be stored in ${PKGDIR}/All)"
	echo "  clean       : clean up all source and temporary files"
	echo
	echo "The following settings will be used for the ebuild process:"
	echo
	echo "  package     : ${PF}" 
	echo "  category    : ${CATEGORY}" 
	echo "  description : ${DESCRIPTION}"
	echo "  system      : ${CHOST}" 
	echo "  c flags     : ${CFLAGS}" 
	echo "  c++ flags   : ${CXXFLAGS}" 
	echo "  make flags  : ${MAKEOPTS}" 
	echo -n "  build mode  : "
	if [ -n "${DEBUG}" ]
	then
	    echo "debug (large)"
	else
	    echo "production (stripped)"
	fi
	echo "  merge to    : ${ROOT}" 
	echo 
	if [ -n "$USE" ]
	then
	    echo "Additionally, support for the following toolkits will be enabled if necessary:"
	    echo 
	    echo "  ${USE}"
	fi    
	echo
}

#if [ -e ${PEBUILD} ]
#then
#	source ${PEBUILD}
#fi
source ${EBUILD}

#this is a little trick to define ${A} if it hasn't been defined yet
if [ "${A}" = "" ]
then
	if [ "${SRC_URI}" != "" ]
	then
		rm -f ${T}/archives.orig
		for x in ${SRC_URI}
		do
			echo `basename $x` >> ${T}/archives.orig
		done
		cat ${T}/archives.orig | sort | uniq > ${T}/archives
		rm ${T}/archives.orig
		export A=`cat ${T}/archives`
		rm ${T}/archives
	fi
fi

if [ "${RDEPEND}" = "" ]
then
	export RDEPEND=${DEPEND}
fi

count=1
while [ $count -le $# ]
do
	eval "myarg=\${${count}}"
	case $myarg in
	prerm|postrm|preinst|postinst|config)
		if [ "$PORTAGE_DEBUG" = "0" ]
		then
		  pkg_${myarg}
		else
		  set -x
		  pkg_${myarg}
		  set +x
		fi
	    ;;
	unpack|compile|help|batchdigest|touch|clean|fetch|digest|pkginfo|pkgloc|unmerge|merge|package|install|rpm)
	    if [ "$PORTAGE_DEBUG" = "0" ]
	    then
	      dyn_${myarg}
	    else
	      set -x
	      dyn_${myarg}
	      set +x
	    fi
	    ;;
	depend)
		echo $DEPEND
		echo $RDEPEND
		;;
	*)
	    echo "Please specify a valid command."
		echo
		dyn_help
		;;
	esac
	if [ $? -ne 0 ]
	then
		exit 1
	fi
	count=$(( $count + 1))
done
